import 'package:flutter/material.dart';

class ThemeState {
  final ThemeMode themeMode;
  
  ThemeState({this.themeMode = ThemeMode.light});
  
  bool get isDark => themeMode == ThemeMode.dark;
  
  ThemeState copyWith({ThemeMode? themeMode}) {
    return ThemeState(
      themeMode: themeMode ?? this.themeMode,
    );
  }
}
