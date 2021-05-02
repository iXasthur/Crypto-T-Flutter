// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crypto_dashboard.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CryptoDashboard _$CryptoDashboardFromJson(Map<String, dynamic> json) {
  return CryptoDashboard()
    ..assets = (json['assets'] as List<dynamic>)
        .map((e) => CryptoAsset.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$CryptoDashboardToJson(CryptoDashboard instance) =>
    <String, dynamic>{
      'assets': instance.assets,
    };
