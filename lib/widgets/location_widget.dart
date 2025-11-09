import 'package:flutter/cupertino.dart';

import 'package:google_fonts/google_fonts.dart';

class LocationWidget extends StatelessWidget {
  final String location;

  const LocationWidget({
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 6,
        vertical: 2,
      ),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        location,
        style: GoogleFonts.rubik(
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
