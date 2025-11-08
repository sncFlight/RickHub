import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:rick_hub/modules/favorites/bloc/favorites_bloc.dart';
import 'package:rick_hub/modules/favorites/bloc/favorites_event.dart';
import 'package:rick_hub/modules/favorites/models/favorite_character.dart';
import 'package:rick_hub/navigation/main_navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(FavoriteCharacterAdapter());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoritesBloc()..add(LoadFavoritesEvent()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MainNavigation(),
      ),
    );
  }
}
