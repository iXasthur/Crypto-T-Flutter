import 'package:crypto_t/models/crypto_asset.dart';
import 'package:crypto_t/pages/auth_scaffold.dart';
import 'package:crypto_t/pages/crypto_creator_page.dart';
import 'package:crypto_t/pages/crypto_details_page.dart';
import 'package:crypto_t/pages/loading_scaffold.dart';
import 'package:crypto_t/pages/location_picker_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home_scaffold.dart';

class AppRoutes {
  static const String root = '/';

  static const String auth = '/auth';

  static const String home = '/home';
  static const String details = '/home/details';

  static const String creator = '/creator';

  static const String location_picker = '/creator/location_picker';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case root:
        return MaterialPageRoute(builder: (_) => LoadingScaffold());
      case auth:
        return MaterialPageRoute(builder: (_) => AuthScaffold());
      case home:
        return MaterialPageRoute(builder: (_) => HomeScaffold());
      case details:
        if (args is String) {
          return MaterialPageRoute(builder: (_) => CryptoDetailsPage(assetId: args));
        }
        break;
      case creator:
        if (args is CryptoAsset?) {
          return MaterialPageRoute(builder: (_) => CryptoCreator(asset: args));
        }
        break;
      case location_picker:
        return MaterialPageRoute(builder: (_) => LocationPickerScaffold());
    }

    return _errorRoute();
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('Invalid Route'),
        ),
      );
    });
  }
}