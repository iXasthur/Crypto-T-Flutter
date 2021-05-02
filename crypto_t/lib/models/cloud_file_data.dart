import 'package:json_annotation/json_annotation.dart';

part 'cloud_file_data.g.dart';

@JsonSerializable()
class CloudFileData {

  String path;
  String downloadURL;

  CloudFileData(this.path, this.downloadURL);

  factory CloudFileData.fromJson(Map<String, dynamic> json) => _$CloudFileDataFromJson(json);
  Map<String, dynamic> toJson() => _$CloudFileDataToJson(this);

}