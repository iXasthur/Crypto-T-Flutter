import 'dart:async';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:crypto_t/pages/app_routes.dart';
import 'package:crypto_t/utils/animation_assistant.dart';
import 'package:crypto_t/utils/app_styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();

  runApp(EasyLocalization(
    supportedLocales: [Locale('en'), Locale('ru')],
    fallbackLocale: Locale('en'),
    path: 'assets/translations',
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {

  static AnimationAssistant? globalAnimationAssistant;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  late AnimationAssistant _animationAssistant;

  @override
  void initState() {
    super.initState();
    _animationAssistant = AnimationAssistant(context);
    MyApp.globalAnimationAssistant = _animationAssistant;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        WidgetsBinding.instance?.focusManager.primaryFocus?.unfocus();
      },
      child: AdaptiveTheme(
        light: AppStylesPrimary.main,
        dark: AppStylesPrimary.dark,
        initial: AdaptiveThemeMode.light,
        builder: (theme, darkTheme) => GlobalLoaderOverlay(
          child: StreamBuilder<bool>(
            initialData: false,
            stream: _animationAssistant.stream,
            builder: (context, snapshot) {
              var absorb = snapshot.data ?? false;
              return AbsorbPointer(
                absorbing: absorb,
                child: MaterialApp(
                  title: AppStylesPrimary.title,
                  theme: theme,
                  darkTheme: darkTheme,
                  initialRoute: AppRoutes.root,
                  onGenerateRoute: AppRoutes.generateRoute,
                  localizationsDelegates: context.localizationDelegates,
                  supportedLocales: context.supportedLocales,
                  locale: context.locale,
                ),
              );
            }
          ),
        ),
      ),
    );
  }
}
