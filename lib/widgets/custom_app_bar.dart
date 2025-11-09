import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:rick_hub/modules/theme/bloc/theme_bloc.dart';
import 'package:rick_hub/modules/theme/bloc/theme_event.dart';
import 'package:rick_hub/modules/theme/bloc/theme_state.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget widget;

  const CustomAppBar({required this.title, required this.widget});

  @override
  PreferredSizeWidget build(BuildContext context) {
    return AppBar(
      leading: Navigator.canPop(context)
          ? IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back_ios),
            )
          : SizedBox.shrink(),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(18)),
      ),
      titleSpacing: 0,
      title: Text(
        title,
        style: GoogleFonts.rubik(
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.w500,
        ),
      ),
      actions: [
        _buildThemeToggle(),
        SizedBox(width: 8),
        widget,
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

Widget _buildThemeToggle() {
  return BlocBuilder<ThemeBloc, ThemeState>(
    builder: (context, state) {
      return IconButton(
        icon: Icon(
          state.isDark ? Icons.light_mode : Icons.dark_mode,
          color: Colors.white,
        ),
        onPressed: () {
          context.read<ThemeBloc>().add(
                ThemeChanged(isDark: !state.isDark),
              );
        },
      );
    },
  );
}
