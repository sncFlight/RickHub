import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextStyles {
  static TextStyle rubik({
    required Color color,
    required double? fontSize,
    required FontWeight? fontWeight,
  }) {
    return GoogleFonts.rubik(
      textStyle: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}