import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LogoWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: ShapeDecoration(
        color: Color(0xFF298E3E),
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: Color(0xFF79A611)),
          borderRadius: BorderRadius.circular(36),
        ),
        shadows: [
          BoxShadow(
            color: Color(0xA56E980B),
            blurRadius: 19,
            offset: Offset(0, 5),
            spreadRadius: 0,
          )
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'RICK HUB',
            textAlign: TextAlign.center,
            style: GoogleFonts.rubikBubbles(
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 31,
                fontWeight: FontWeight.w400,
                height: 0,
                letterSpacing: -0.27,
              ),
            ),
          ),
        ],
      ),
    );
  }
}