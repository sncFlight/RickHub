import 'package:flutter/cupertino.dart';

class LocationWidget extends StatelessWidget {
  final String location;

  const LocationWidget({
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 43,
      height: 18,
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: ShapeDecoration(
        color: Color(0xFFEEEEEE),
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
            'Earth',
            textAlign: TextAlign.right,
            style: TextStyle(
              color: Color(0xFF2E3A59),
              fontSize: 12,
              fontFamily: 'Rubik',
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
        ],
      ),
    );
  }

}