import 'package:flutter/material.dart';
import 'package:rick_hub/constants/palette.dart';
import 'package:rick_hub/constants/text_styles.dart';

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
      backgroundColor: Palette.appBar,
      leading: Navigator.canPop(context)
        ? IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios),
        )
        : SizedBox.shrink(),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(18)),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyles.rubik(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w400,
            ),
          ),
          widget,
        ],
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

}