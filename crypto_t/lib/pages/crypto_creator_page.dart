import 'package:crypto_t/models/crypto_asset.dart';
import 'package:flutter/material.dart';

class CryptoCreator extends StatefulWidget {
  final CryptoAsset? asset;

  const CryptoCreator({Key? key, this.asset}) : super(key: key);

  @override
  _CryptoCreatorState createState() => _CryptoCreatorState();
}

class _CryptoCreatorState extends State<CryptoCreator> {
  @override
  Widget build(BuildContext context) {
    return Text("Creator");
  }
}