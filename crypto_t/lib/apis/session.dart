import 'package:crypto_t/apis/firebase_crypto_manager.dart';
import 'package:crypto_t/models/crypto_asset.dart';
import 'package:crypto_t/models/crypto_dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Session {
  Session._internal(); // Private constructor

  static final Session shared = Session._internal();

  FirebaseCryptoManager _cryptoAssetManager = FirebaseCryptoManager();
  CryptoDashboard? _dashboard;
  bool _initialized = false;

  bool isInitialized() => _initialized;

  List<CryptoAsset>? getLocalAssets() {
    if (_dashboard?.assets != null) {
      return List<CryptoAsset>.from(_dashboard!.assets);
    } else {
      return null;
    }
  }

  CryptoAsset? getLocalAsset(String id) {
    try {
      return _dashboard?.assets.firstWhere((element) => element.id == id);
    } catch (e) {
      return null;
    }
  }

  void deleteLocalAsset(CryptoAsset asset) {
    _dashboard?.assets.remove(asset);
  }

  void deleteRemoteAsset(CryptoAsset asset, Function(Exception?) completion) {
    void handleResult(Exception? error) {
      if (error != null) {
        print(error);
        completion(error);
      } else {
        deleteLocalAsset(asset);
        completion(null);
      }
    }

    _cryptoAssetManager.deleteRemoteAsset(asset, (error) => handleResult(error));
  }

  void addLocalAssetIfNeeded(CryptoAsset asset) {
    var c = _dashboard?.assets.contains(asset);
    if (c != null && !c) {
      _dashboard?.assets.add(asset);
    }
  }

  void updateRemoteAsset(CryptoAsset asset, Uri? iconUri, Uri? videoUri, Function(Exception?) completion) {
    void completed(CryptoAsset? updatedAsset, Exception? error) {
      if (error != null) {
        print(error);
        completion(error);
      } else if (updatedAsset != null) {
        addLocalAssetIfNeeded(updatedAsset);
        completion(null);
      } else {
        completion(Exception(
            "Invalid updateRemoteAsset form CryptoAssetFirebaseManager closure return"));
      }
    }

    _cryptoAssetManager.updateRemoteAsset(
        asset, iconUri, videoUri, (updatedAsset, error) =>
        completed(updatedAsset, error));
  }

  void syncDashboard(Function() onCompleted) {
    void completed(List<CryptoAsset>? assets, Exception? error) {
      if (error != null) {
        print(error);
        _dashboard?.assets = List.empty(growable: true);
      } else if (assets != null) {
        _dashboard?.assets = assets;
      } else {
        print("Didn't receive assets and error");
        _dashboard?.assets = List.empty(growable: true);
      }
      onCompleted();
    }

    _cryptoAssetManager.getRemoteAssets((assets, error) =>
        completed(assets, error));
  }

  void _initialize(Function() onCompleted) {
    void completed() {
      _initialized = true;
      onCompleted();
    }

    _dashboard = CryptoDashboard();
    syncDashboard(() => completed());
  }

  void destroy(Function() onCompleted) async {
    _initialized = false;
    await FirebaseAuth.instance.signOut();
    _dashboard = null;
    onCompleted();
  }

  void restore(Function(Exception?) completion) {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _initialize(() => completion(null));
    } else {
      completion(Exception("User not signed in"));
    }
  }

  void signUpEmail(String email, String password,
      Function(Exception?) completion) async {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((_) => handleFirebaseAuthResponse(null, completion))
        .catchError((error) => handleFirebaseAuthResponse(error, completion));
  }

  void signInEmail(String email, String password,
      Function(Exception?) completion) async {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((_) => handleFirebaseAuthResponse(null, completion))
        .catchError((error) => handleFirebaseAuthResponse(error, completion));
  }

  void handleFirebaseAuthResponse(Exception? error,
      Function(Exception? error) completion) {
    if (error != null) {
      completion(error);
      return;
    }

    _initialize(() =>
    {
      if (_initialized)
        completion(null)
      else
        completion(new Exception("Unable to initialize session"))
    });
  }
}
