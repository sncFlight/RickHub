import 'package:flutter/cupertino.dart';
import 'package:rick_hub/constants/palette.dart';
import 'package:rick_hub/constants/text_styles.dart';

class LocationWidget extends StatelessWidget {
  final String location;

  const LocationWidget({
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 18,
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: ShapeDecoration(
        color: Palette.locationRect,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            location,
            textAlign: TextAlign.right,
            style: TextStyles.rubik(
              color: Palette.darkBlue,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

}