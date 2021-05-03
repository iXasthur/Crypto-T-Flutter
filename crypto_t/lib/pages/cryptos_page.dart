import 'package:crypto_t/apis/session.dart';
import 'package:crypto_t/models/crypto_asset.dart';
import 'package:crypto_t/pages/crypto_cell_view.dart';
import 'package:crypto_t/utils/app_styles.dart';
import 'package:flutter/material.dart';

class CryptosPage extends StatefulWidget {
  @override
  _CryptosPageState createState() => _CryptosPageState();
}

class _CryptosPageState extends State<CryptosPage> {

  List<CryptoAsset> _assets = Session.shared.getLocalAssets() ?? [];

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      // Create a grid with 2 columns. If you change the scrollDirection to
      // horizontal, this produces 2 rows.
      crossAxisCount: 3,
      padding: EdgeInsets.fromLTRB(
        AppStylesPrimary.safeAreaX,
        0,
        AppStylesPrimary.safeAreaX,
        0,
      ),
      // Generate 100 widgets that display their index in the List.
      children: List.generate(_assets.length, (index) {
        var item = _assets[index];

        return Center(
          child: CryptoCell(asset: item),
        );
      }),
    );
  }
}