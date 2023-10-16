import 'package:flutter/material.dart';
import 'package:rick_hub/constants/Palette.dart';

class SearchInput extends StatelessWidget {
  final Function(String) onChanged;

  const SearchInput({required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) => onChanged(value),
      decoration: InputDecoration(
        enabled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(47),
          borderSide: BorderSide(
            color: Palette.searchDecorationGreen,
          ),
        ),
        hintText: 'Wabba Labba Dub Dub',
        hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 18
        ),
        prefixIcon: Container(
          padding: EdgeInsets.all(15),
          child: Icon(
            Icons.search,
          ),
          width: 18,
        )
      ),
    );
  }
}