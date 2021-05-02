// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crypto_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CryptoEvent _$CryptoEventFromJson(Map<String, dynamic> json) {
  return CryptoEvent(
    json['note'] as String,
    json['latitude'] as String,
    json['longitude'] as String,
  );
}

Map<String, dynamic> _$CryptoEventToJson(CryptoEvent instance) =>
    <String, dynamic>{
      'note': instance.note,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
