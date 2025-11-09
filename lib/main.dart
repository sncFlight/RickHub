import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:rick_hub/constants/app_themes.dart';
import 'package:rick_hub/modules/favorites/bloc/favorites_bloc.dart';
import 'package:rick_hub/modules/favorites/bloc/favorites_event.dart';
import 'package:rick_hub/modules/favorites/models/favorite_character.dart';
import 'package:rick_hub/modules/theme/bloc/theme_bloc.dart';
import 'package:rick_hub/modules/theme/bloc/theme_event.dart';
import 'package:rick_hub/modules/theme/bloc/theme_state.dart';
import 'package:rick_hub/navigation/main_navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(FavoriteCharacterAdapter());

  await Hive.openBox('settings');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FavoritesBloc()..add(LoadFavoritesEvent()),
        ),
        BlocProvider(
          create: (context) => ThemeBloc()..add(ThemeInitialized()),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppThemes.lightTheme,
            darkTheme: AppThemes.darkTheme,
            themeMode: themeState.themeMode,
            home: MainNavigation(),
          );
        },
      ),
    );
  }
}
