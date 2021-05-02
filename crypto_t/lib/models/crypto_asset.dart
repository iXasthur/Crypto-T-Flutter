import 'cloud_file_data.dart';
import 'crypto_event.dart';

class CryptoAsset {

  String id;
  String name;
  String code;
  String description;
  CloudFileData? iconFileData;
  CloudFileData? videoFileData;
  CryptoEvent? suggestedEvent;

  CryptoAsset(
      this.id,
      this.name,
      this.code,
      this.description,
      this.iconFileData,
      this.videoFileData,
      this.suggestedEvent
      );

}