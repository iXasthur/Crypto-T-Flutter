import 'package:crypto_t/models/crypto_asset.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CryptoCell extends StatefulWidget {
  final CryptoAsset asset;

  const CryptoCell({Key? key, required this.asset}) : super(key: key);

  @override
  _CryptoCellState createState() => _CryptoCellState();
}

class _CryptoCellState extends State<CryptoCell> {
  @override
  Widget build(BuildContext context) {
    var imageUrl = widget.asset.iconFileData?.downloadURL;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 50,
          height: 50,
          child: imageUrl != null 
            ? ClipRRect(
                borderRadius: BorderRadius.circular(90.0),
                child: Image.network(imageUrl),
              )
            : Icon(CupertinoIcons.cube, size: 40),
        ),
        SizedBox(height: 5),
        Text(widget.asset.name),
        Text(widget.asset.code),
      ],
    );
  }
}