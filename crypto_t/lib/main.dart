import 'package:crypto_t/pages/app_routes.dart';
import 'package:crypto_t/utils/app_styles.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
