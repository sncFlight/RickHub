import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_hub/modules/auth/login/login_screen.dart';
import 'package:rick_hub/modules/auth/login/repositories/local_login_repository.dart';
import 'package:rick_hub/modules/home/characters_screen.dart';
import 'package:rick_hub/modules/home/services/character_repository.dart';
import 'package:rick_hub/modules/pin_code/pin_code_screen.dart';
import 'package:rick_hub/modules/pin_code/repositories/pin_code_repository.dart';
import 'package:rick_hub/route/route_constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        RouteConstants.loginRoute: (context) => PinCodeScreen(),
        RouteConstants.pinCodeRoute: (context) => PinCodeScreen(),
        // RouteConstants.charactersRoute: (context) => CharactersScreen(),
      },
      home: RepositoryProvider(
        create: (context) => CharactersRepository(),
          child: CharactersScreen(),
      ),
    );
  }
}