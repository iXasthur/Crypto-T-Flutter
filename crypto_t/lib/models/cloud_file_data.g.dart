// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cloud_file_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CloudFileData _$CloudFileDataFromJson(Map<String, dynamic> json) {
  return CloudFileData(
    json['path'] as String,
    json['downloadURL'] as String,
  );
}

Map<String, dynamic> _$CloudFileDataToJson(CloudFileData instance) =>
    <String, dynamic>{
      'path': instance.path,
      'downloadURL': instance.downloadURL,
    };
