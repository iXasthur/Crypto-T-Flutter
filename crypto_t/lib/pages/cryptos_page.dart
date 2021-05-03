import 'package:crypto_t/apis/session.dart';
import 'package:crypto_t/models/crypto_asset.dart';
import 'package:crypto_t/pages/app_routes.dart';
import 'package:crypto_t/pages/crypto_cell_view.dart';
import 'package:crypto_t/utils/app_styles.dart';
import 'package:flutter/material.dart';

class CryptosPage extends StatefulWidget {
  @override
  _CryptosPageState createState() => _CryptosPageState();
}

class _CryptosPageState extends State<CryptosPage> {

  List<CryptoAsset> _assets = [];

  @override
  Widget build(BuildContext context) {
    _assets = Session.shared.getLocalAssets() ?? [];

    return GridView.count(
      crossAxisCount: 3,
      padding: EdgeInsets.fromLTRB(
        AppStylesPrimary.safeAreaX/2,
        0,
        AppStylesPrimary.safeAreaX/2,
        0,
      ),
      children: List.generate(_assets.length, (index) {
        var item = _assets[index];

        return Padding(
          padding: EdgeInsets.all(2),
          child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.details, arguments: item);
              },
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).scaffoldBackgroundColor, // background
                onPrimary: Theme.of(context).textTheme.bodyText1!.color, // foreground
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: Center(
                child: CryptoCell(asset: item),
              )),
        );
      }),
    );
  }
}