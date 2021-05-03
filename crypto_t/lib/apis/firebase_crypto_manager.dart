import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_t/models/cloud_file_data.dart';
import 'package:crypto_t/models/crypto_asset.dart';
import 'package:crypto_t/utils/constants.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class FirebaseCryptoManager {

  FirebaseFirestore _db = FirebaseFirestore.instance;
  FirebaseStorage _storage = FirebaseStorage.instance;


  void deleteRemoteAsset(CryptoAsset asset, Function(Exception?) completion)
  {

    var iconFile = asset.iconFileData;
    if (iconFile != null) {
      deleteFile(iconFile, (error) =>
      {
        if (error != null)
          {
            print(error)
          } else
          {
            print("Deleted file with path " + iconFile.path)
          }
      });
    }

    var videoFile = asset.videoFileData;
    if (videoFile != null) {
      deleteFile(videoFile, (error) =>
      {
        if (error != null)
          {
            print(error)
          } else
          {
            print("Deleted file with path " + videoFile.path)
          }
      });
    }

    _db.collection(Constants.assetsCollectionName).doc(asset.id)
        .delete()
        .then((value) => completion(null))
        .catchError((error) => completion(error));
  }

  void getStorageDownloadURL(String path, Function(Uri?, Exception?) completion)
  {
    var storageRef = _storage.ref();
    var fileRef = storageRef.child(path);
    fileRef
    .getDownloadURL()
        .then((value) => completion(Uri.parse(value), null))
        .catchError((error) => completion(null, error));
  }

  void deleteFile(CloudFileData file, Function(Exception?) completion)
  {
    var storageRef = _storage.ref();
    var fileRef = storageRef.child(file.path);
    fileRef
        .delete()
        .then((value) => completion(null))
        .catchError((error) => completion(error));
  }

  void uploadFile(Reference fileRef, File file, SettableMetadata metadata, Function(CloudFileData?, Exception?) completion) {
    void onSuccess(Function(CloudFileData?, Exception?) completion) {
      getStorageDownloadURL(fileRef.fullPath, (uri, error) =>
      {
        if (uri != null)
          completion(CloudFileData(fileRef.fullPath, uri.toString()), null)
        else
          completion(null,
              error ?? Exception("Both uri and error in uploadFile are null"))
      });
    }

    fileRef
        .putFile(file, metadata)
        .then((value) => onSuccess(completion))
        .catchError((error) => completion(null, error));
  }

  void uploadImage(File imageFile, Function(CloudFileData?, Exception?) completion) {
    var storageRef = _storage.ref();
    var path = Constants.imagesFolderName + "/" + Uuid().v4() +"-flutter-image";
    var imageRef = storageRef.child(path);
    var metadata = SettableMetadata();
    uploadFile(imageRef, imageFile, metadata, (fileData, error) => completion(fileData, error));
  }

  void uploadVideo(File videoFile, Function(CloudFileData?, Exception?) completion)
  {
    var storageRef = _storage.ref();
    var path = Constants.videosFolderName + "/" + Uuid().v4() +"-flutter-video";
    var videoRef = storageRef.child(path);
    var metadata = SettableMetadata();
    uploadFile(videoRef, videoFile, metadata, (fileData, error) => completion(fileData, error));
  }

  void uploadAsset(CryptoAsset asset, Function(Exception?) completion)
  {
    var document = _db.collection(Constants.assetsCollectionName).doc(asset.id);
    document
        .set(asset.toJson())
        .then((value) => completion(null))
        .catchError((error) => completion(error));
  }

  void updateRemoteAssetRec(CryptoAsset asset, Uri? iconUri, Uri? videoUri, Function(CryptoAsset?, Exception?) completion) {
    // Upload files 1 by 1 with every call
    // Priority:
    // 1 - Video
    // 2 - Image
    // 3 - Asset

    if (asset.videoFileData?.downloadURL != videoUri?.toString()) {
      var videoFileData = asset.videoFileData;

      // Delete old file if exists
      if (videoFileData != null) {
        var videoFileDataCopy = CloudFileData(
            videoFileData.path,
            videoFileData.downloadURL
        );
        asset.videoFileData = null;
        deleteFile(videoFileDataCopy, (error) =>
        error == null
            ? print("Deleted video with path " + videoFileData.path)
            : print(error));
      }

      // Upload new file with recursive call in completion
      if (videoUri != null) {
        var file = File.fromUri(videoUri);
        uploadVideo(file, (fileData, error) {
          if (fileData != null) {
            asset.videoFileData = fileData;
            var downloadUri = Uri.parse(fileData.downloadURL);
            updateRemoteAssetRec(asset, iconUri, downloadUri, completion);
          } else {
            updateRemoteAssetRec(asset, iconUri, null, completion);
          }
        }
        );
      } else {
        updateRemoteAssetRec(asset, iconUri, videoUri, completion);
      }

      return;
    }


    if (asset.iconFileData?.downloadURL != iconUri?.toString()) {
      var iconFileData = asset.iconFileData;

      // Delete old file if exists
      if (iconFileData != null) {
        var iconFileDataCopy = CloudFileData(
            iconFileData.path,
            iconFileData.downloadURL
        );
        asset.iconFileData = null;
        deleteFile(iconFileDataCopy, (error) =>
        error == null
            ? print("Deleted image with path " + iconFileData.path)
            : print(error));
      }

      // Upload new file with recursive call in completion
      if (iconUri != null) {
        var file = File.fromUri(iconUri);
        uploadImage(file, (fileData, error) {
          if (fileData != null) {
            asset.iconFileData = fileData;
            var downloadUri = Uri.parse(fileData.downloadURL);
            updateRemoteAssetRec(asset, downloadUri, videoUri, completion);
          } else {
            updateRemoteAssetRec(asset, null, videoUri, completion);
          }
        }
        );
      } else {
        updateRemoteAssetRec(asset, iconUri, videoUri, completion);
      }

      return;
    }

    uploadAsset(
        asset, (error) => error != null ? completion(null, error) : completion(
        asset, null));
  }

  void updateRemoteAsset(CryptoAsset asset, Uri? iconUri, Uri? videoUri, Function(CryptoAsset?, Exception?) completion)
  {
    updateRemoteAssetRec(asset, iconUri, videoUri, (updatedAsset, error) => completion(updatedAsset, error));
  }

  void getRemoteAssets(Function(List<CryptoAsset>?, Exception?) completion) {
    void parseSnapshot(QuerySnapshot value, Function(List<CryptoAsset>?, Exception?) completion) {
      var assets = List<CryptoAsset>.empty(growable: true);

      value.docs.forEach((element) {
        var data = element.data();
        try {
          var asset = CryptoAsset.fromJson(data);
          assets.add(asset);
        } catch (e) {
          print('Error parsing json asset:');
          print(data);
          print(e);
        }
      });

      completion(assets, null);
    }

    _db
        .collection(Constants.assetsCollectionName)
        .get()
        .then((value) => parseSnapshot(value, completion))
        .catchError((error) => completion(null, error));
  }
}
