import 'package:crypto_t/models/crypto_asset.dart';
import 'package:flutter/material.dart';

class CryptoDetailsPage extends StatefulWidget {
  final CryptoAsset asset;

  const CryptoDetailsPage({Key? key, required this.asset}) : super(key: key);

  @override
  _CryptoDetailsPageState createState() => _CryptoDetailsPageState();
}

class _CryptoDetailsPageState extends State<CryptoDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.asset.name);
  }
}
