// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crypto_asset.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

// MODIFIED ID FIELD PARSING PROCESS

CryptoAsset _$CryptoAssetFromJson(Map<String, dynamic> json) {
  return CryptoAsset(
    json['id'] == null
        ? Uuid().v4()
        : json['id'] as String,
    json['name'] as String,
    json['code'] as String,
    json['description'] as String,
    json['iconFileData'] == null
        ? null
        : CloudFileData.fromJson(json['iconFileData'] as Map<String, dynamic>),
    json['videoFileData'] == null
        ? null
        : CloudFileData.fromJson(json['videoFileData'] as Map<String, dynamic>),
    json['suggestedEvent'] == null
        ? null
        : CryptoEvent.fromJson(json['suggestedEvent'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CryptoAssetToJson(CryptoAsset instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'description': instance.description,
      'iconFileData': instance.iconFileData?.toJson(),
      'videoFileData': instance.videoFileData?.toJson(),
      'suggestedEvent': instance.suggestedEvent?.toJson(),
    };
