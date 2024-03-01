import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppTheme {
  static ThemeData get light {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        elevation: 0,
        color: Color(0xFFfffffe),
        shape: Border(
          bottom: BorderSide(
            width: 4,
            color: Color(0xFF020826),
          ),
        ),
      ),
      scaffoldBackgroundColor: const Color(0xFFf9f4ef),
      primaryColor: const Color(0xFF716040),
      splashColor: Colors.transparent,
      fontFamily: GoogleFonts.ibmPlexSans().fontFamily,
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: const Color(0xFF020826),
      ),
      useMaterial3: true,
    );
  }
}
