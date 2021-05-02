import 'package:json_annotation/json_annotation.dart';

part 'crypto_event.g.dart';

@JsonSerializable()
class CryptoEvent {

  String note;
  String latitude;
  String longitude;

  CryptoEvent(this.note, this.latitude, this.longitude);

  factory CryptoEvent.fromJson(Map<String, dynamic> json) => _$CryptoEventFromJson(json);
  Map<String, dynamic> toJson() => _$CryptoEventToJson(this);

}