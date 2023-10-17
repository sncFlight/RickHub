import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rick_hub/constants/image_paths.dart';
import 'package:rick_hub/constants/palette.dart';

class SearchInput extends StatelessWidget {
  final Function(String) onChanged;

  const SearchInput({required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      onChanged: (value) => onChanged(value),
      leading: SvgPicture.asset(ImagePaths.search),
      padding: MaterialStatePropertyAll(
        EdgeInsets.symmetric(horizontal: 15),
      ),

      hintText: 'Wabba Labba Dub Dub',
      hintStyle: MaterialStatePropertyAll(TextStyle(
          color: Colors.grey,
          fontSize: 18
        ),
      ),
      shape: MaterialStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(47),
          side: BorderSide(
              color: Palette.searchDecorationGreen,
              width: 2
          ),
        ),
      ),
    );
  }
}