import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rick_hub/constants/image_paths.dart';
import 'package:rick_hub/modules/characters/models/character.dart';
import 'package:rick_hub/widgets/location_widget.dart';

class CharacterWidget extends StatelessWidget {
  final Character character;

  const CharacterWidget({required this.character});

  @override
  Widget build(BuildContext context) {
    final String fullName = character.name;
    final String gender = character.gender;
    final String status = character.status;
    final String originName = character.originName;
    final String locationName = character.locationName;
    final String imageUrl = character.imageUrl;

    final Color statusColor;

    if (status.toLowerCase().contains('alive')) {
      statusColor = Colors.green;
    } else if (status.toLowerCase().contains('unknown')) {
      statusColor = Colors.grey;
    } else {
      statusColor = Colors.red;
    }

    return Container(
      height: 90,
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        color: Colors.white,
        shadows: [
          BoxShadow(
            color: Color(0x335B8911),
            blurRadius: 16,
            offset: Offset(0, 4),
          ),
          BoxShadow(
            color: Color(0x59298E3E),
            offset: Offset(4, -4),
          )
        ],
      ),
     // color: Colors.orange,
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                width: 90,
                child: Image.network(imageUrl),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  height: 16,
                  width: 90,
                  color: statusColor,
                  child: Center(
                    child: Text(
                      status.toUpperCase(),
                      style: GoogleFonts.rubik(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fullName,
                  style: GoogleFonts.rubik(
                    textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    gender,
                    style: GoogleFonts.rubik(
                      textStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 1),
                        child: SvgPicture.asset(ImagePaths.location),
                      ),
                      LocationWidget(location: originName),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: SvgPicture.asset(ImagePaths.arrow),
                      ),
                      LocationWidget(location: locationName),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

}