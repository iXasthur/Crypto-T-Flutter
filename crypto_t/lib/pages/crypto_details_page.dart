import 'package:crypto_t/models/crypto_asset.dart';
import 'package:crypto_t/utils/widget/my_app_bar.dart';
import 'package:flutter/cupertino.dart';
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
    return Scaffold(
      appBar: MyAppBar.createWithAutoBack(
        context,
        title: widget.asset.name,
        onBack: () {

        },
        actions: [
          IconButton(
            onPressed: () {
              // Go to creator
            },
            icon: Icon(CupertinoIcons.pencil),
            splashColor: Colors.transparent,
          ),
        ]
      ),
      body: Text(widget.asset.name),
    );
  }
}
