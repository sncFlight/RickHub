import 'package:flutter/material.dart';
import 'package:rick_hub/modules/home/models/character.dart';
import 'package:rick_hub/widgets/location_widget.dart';

class CharacterWidget extends StatelessWidget {
  final Character character;

  const CharacterWidget({required this.character});

  @override
  Widget build(BuildContext context) {
    final String fullName = character.name;
    final String gender = character.gender;
    final String originName = character.originName;
    final String locationName = character.locationName;
    final String imageUrl = character.imageUrl;

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        shadows: [
          BoxShadow(
            color: Color(0x335B8911),
            blurRadius: 16,
            offset: Offset(0, 4),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Color(0x59298E3E),
            blurRadius: 0,
            offset: Offset(4, -4),
            spreadRadius: 0,
          )
        ],
      ),
      height: 90,
     // color: Colors.orange,
      child: Row(
        children: [
          Container(
            height: 90,
            width: 90,
            child: Image.network(imageUrl),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  fullName,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'Rubik',
                    fontWeight: FontWeight.w700,
                    height: 0.10,
                  ),
                ),
                Text(
                  gender,
                  style: TextStyle(
                    color: Color(0xFFA6AAB4),
                    fontSize: 12,
                    fontFamily: 'Rubik',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
                Row(
                    children: [
                      Icon(Icons.location_pin),
                      LocationWidget(location: originName),
                      Icon(Icons.arrow_right_alt),
                      LocationWidget(location: locationName),
                    ]
                )
              ],
            ),
          )
        ],
      ),
    );
  }

}