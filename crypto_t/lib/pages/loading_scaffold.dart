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

  @override
  void initState() {
    super.initState();

    Future(() {
      Navigator.pushReplacementNamed(context, AppRoutes.auth);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
              color: Theme.of(context).backgroundColor,
              size: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}
