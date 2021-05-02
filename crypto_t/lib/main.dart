import 'package:crypto_t/pages/app_routes.dart';
import 'package:crypto_t/utils/app_styles.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        WidgetsBinding.instance?.focusManager.primaryFocus?.unfocus();
      },
      child: MaterialApp(
        title: AppStylesPrimary.title,
        theme: AppStylesPrimary.main,
        initialRoute: AppRoutes.root,
        onGenerateRoute: AppRoutes.generateRoute,
      ),
    );
  }
}
