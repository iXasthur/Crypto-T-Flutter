import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStylesPrimary {
  static final String title = 'Crypto-T-Flutter';

  static final double safeAreaX = 28;

  static final ThemeData main = ThemeData(
    primarySwatch: Colors.purple,
    brightness: Brightness.light,
    textTheme: GoogleFonts.quicksandTextTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}