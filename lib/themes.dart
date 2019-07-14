import 'package:flutter/material.dart';

ThemeData lightTheme() {
  return ThemeData(
    brightness: Brightness.light,
    primaryColor: Color(0xFF0d47a1),
    accentColor: Colors.lightBlue,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF0d47a1)
    )
  );
}

ThemeData darkTheme() {
  return ThemeData(
    brightness: Brightness.dark,
    canvasColor: Color(0xFF202125),
    primaryColor: Color(0xFF195BBC),
    primaryColorLight: Color(0xFF2C2E2F),
    primaryColorDark: Color(0xFF202125),
    accentColor: Color(0xFF8CB5FE),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF0E397A),
      foregroundColor: Colors.white
    ),
  );
}