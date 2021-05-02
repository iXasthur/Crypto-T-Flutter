import 'crypto_asset.dart';
import 'package:json_annotation/json_annotation.dart';

part 'crypto_dashboard.g.dart';

@JsonSerializable()
class CryptoDashboard {

  List<CryptoAsset> assets = List.empty();

  CryptoDashboard();

  factory CryptoDashboard.fromJson(Map<String, dynamic> json) => _$CryptoDashboardFromJson(json);
  Map<String, dynamic> toJson() => _$CryptoDashboardToJson(this);

}