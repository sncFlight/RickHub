import 'package:flutter/material.dart';
import 'package:rick_hub/modules/auth/login/login_screen.dart';
import 'package:rick_hub/modules/characters/characters_screen.dart';
import 'package:rick_hub/modules/pin_code/pin_code_screen.dart';
import 'package:rick_hub/constants/route_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _checkPinCode(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          bool hasPinCode = snapshot.data ?? false;

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            routes: {
              RouteConstants.loginRoute: (context) => LoginScreen(),
              RouteConstants.pinCodeRoute: (context) => PinCodeScreen(),
              RouteConstants.charactersRoute: (context) => CharactersScreen(),
            },
            initialRoute: hasPinCode
              ? RouteConstants.pinCodeRoute
              : RouteConstants.loginRoute,
          );
        } else {
          // Show a loading indicator or some placeholder while checking pin code
          return CircularProgressIndicator();
        }
      },
    );
  }

  Future<bool> _checkPinCode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('pin_code');
  }
}
