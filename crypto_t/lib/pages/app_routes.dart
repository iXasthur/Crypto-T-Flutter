import 'package:crypto_t/pages/auth_scaffold.dart';
import 'package:crypto_t/pages/loading_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home_scaffold.dart';

class AppRoutes {
  static const String root = '/';

  static const String auth = '/auth';

  static const String home = '/home';
  static const String details = '/home/details';

  static const String creator = '/creator';

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