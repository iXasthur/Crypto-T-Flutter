import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:easy_localization/easy_localization.dart';

import 'app_routes.dart';

class LoadingScaffold extends StatefulWidget {
  LoadingScaffold({Key? key}) : super(key: key);

  @override
  _LoadingScaffoldState createState() => _LoadingScaffoldState();
}

class _LoadingScaffoldState extends State<LoadingScaffold> {

  bool _connected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.active) {
            if (!_connected) {
              _connected = true;
              Future(() {
                Navigator.pushReplacementNamed(context, AppRoutes.auth);
              });
            }
          }

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '| LOADING |'.tr(),
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 15),
                SpinKitThreeBounce(
                  color: Theme
                      .of(context)
                      .backgroundColor,
                  size: 20.0,
                ),
              ],
            ),
          );
        },
      )
    );
  }
}
