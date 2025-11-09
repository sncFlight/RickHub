import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:rick_hub/resources/images.dart';

class EmptyStateWidget extends StatelessWidget {
  final String text;

  const EmptyStateWidget({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            Images.sadMorty,
            width: 100,
            height: 100,
          ),
          const SizedBox(height: 10),
          Text(
            text,
            style: GoogleFonts.rubik(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
