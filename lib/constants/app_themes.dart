import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class AppThemes {
  static const Color rickCyan = Color(0xFF11B0C8);
  static const Color mortyGreen = Color(0xFF97CE4C);

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: rickCyan,
    scaffoldBackgroundColor: Color(0xFFF5F7FA),
    cardColor: Colors.white,
    colorScheme: ColorScheme.light(
      primary: rickCyan,
      secondary: mortyGreen,
      surface: Colors.white,
      error: Color(0xFFE53935),
      tertiary: Color(0xFFFFA726),
      onPrimary: Colors.white,
      onSurface: Color(0xFF202329),
    ),
    dividerColor: Color(0xFFE0E0E0),
    disabledColor: Color(0xFF9E9E9E),
    appBarTheme: AppBarTheme(
      backgroundColor: rickCyan,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: GoogleFonts.rubik(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.w400,
      ),
    ),
    textTheme: TextTheme(
      displayLarge: GoogleFonts.rubik(
        color: Color(0xFF202329),
        fontSize: 24,
        fontWeight: FontWeight.w700,
      ),
      bodyLarge: GoogleFonts.rubik(color: Color(0xFF202329)),
      bodyMedium: GoogleFonts.rubik(color: Color(0xFF6E7B8A)),
      labelLarge: GoogleFonts.rubik(color: Colors.white),
    ),
    iconTheme: IconThemeData(color: rickCyan),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: rickCyan,
    scaffoldBackgroundColor: Color(0xFF121212),
    cardColor: Color(0xFF1E1E1E),
    colorScheme: ColorScheme.dark(
      primary: rickCyan,
      secondary: mortyGreen,
      surface: Color(0xFF1E1E1E),
      error: Color(0xFFE53935),
      tertiary: Color(0xFFFFA726),
      onPrimary: Colors.white,
      onSurface: Color(0xFFE0E0E0),
    ),
    dividerColor: Colors.white12,
    disabledColor: Color(0xFF757575),
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFF0A8A99),
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: GoogleFonts.rubik(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.w400,
      ),
    ),
    iconTheme: IconThemeData(color: rickCyan),
  );
}
