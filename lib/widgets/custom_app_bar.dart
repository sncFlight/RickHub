import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rick_hub/constants/image_paths.dart';
import 'package:rick_hub/constants/palette.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget widget;

  const CustomAppBar({
    required this.title,
    required this.widget
  });

  @override
  PreferredSizeWidget build(BuildContext context) {
    return AppBar(
      backgroundColor: Palette.appBarGreen,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(18)),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.arrow_back_ios),
              ),
              Text('Enter PIN-code'),
            ],
          ),
          widget,
          // Container(
          //   width: 30,
          //   height: 30,
          //   decoration: BoxDecoration(
          //     shape: BoxShape.circle,
          //     border: Border.all(
          //         color: Colors.white
          //     )
          //   ),
          //   child: SvgPicture.asset(
          //     ImagePaths.heart,
          //     width: 24,
          //     height: 24,
          //   ),
          // ),
        ],
      ),
      // automaticallyImplyLeading: true,
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

}