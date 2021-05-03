import 'package:uuid/uuid.dart';

import 'cloud_file_data.dart';
import 'crypto_event.dart';
import 'package:json_annotation/json_annotation.dart';

part 'crypto_asset.g.dart';

@JsonSerializable(includeIfNull: true, explicitToJson: true)
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


  factory CryptoAsset.fromJson(Map<String, dynamic> json) => _$CryptoAssetFromJson(json);
  Map<String, dynamic> toJson() => _$CryptoAssetToJson(this);

}