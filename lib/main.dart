import 'package:flutter/material.dart';
import 'package:rick_hub/modules/auth/login/login_screen.dart';
import 'package:rick_hub/modules/characters/characters_screen.dart';
import 'package:rick_hub/modules/pin_code/pin_code_screen.dart';
import 'package:rick_hub/constants/route_constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        RouteConstants.loginRoute: (context) => LoginScreen(),
        RouteConstants.pinCodeRoute: (context) => PinCodeScreen(),
        RouteConstants.charactersRoute: (context) => CharactersScreen(),
      },
      home: PinCodeScreen(),
    );
  }
}