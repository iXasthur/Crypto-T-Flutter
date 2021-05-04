import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStylesPrimary {
  static final String title = 'Crypto-T-Flutter';

  static final double safeAreaX = 28;
  static final double safeAreaYTop = 15;

  static final ThemeData main = ThemeData(
    primarySwatch: Colors.purple,
    brightness: Brightness.light,
    textTheme: GoogleFonts.quicksandTextTheme(
        ThemeData(brightness: Brightness.light).textTheme
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static final ThemeData dark = ThemeData(
    primarySwatch: Colors.purple,
    brightness: Brightness.dark,
    textTheme: GoogleFonts.quicksandTextTheme(
        ThemeData(brightness: Brightness.dark).textTheme
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}