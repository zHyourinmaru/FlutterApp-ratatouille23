import 'package:flutter/material.dart';

class TextAppTheme {
  static const mainGreen = Color(0xFF4CB963);
  static const mainYellow = Color(0xFFFDD849);
  static const mainGray = Color(0xFF737F84);
  static const darkGreen = Color(0xFF379237);
  static const lightGray = Color(0xFFC7CBCD);
  static const darkGray = Color(0xFF605D5D);

  static TextTheme lightTextTheme = const TextTheme(
      titleLarge: TextStyle(
          fontFamily: 'Outfit',
          fontSize: 44,
          color: mainYellow,
          fontWeight: FontWeight.bold),
      titleMedium: TextStyle(
          fontFamily: 'Outfit',
          fontSize: 32,
          color: mainYellow,
          fontWeight: FontWeight.bold),
      titleSmall: TextStyle(
          fontFamily: 'Outfit',
          fontSize: 26,
          color: mainYellow,
          fontWeight: FontWeight.bold),
      headlineLarge:
          TextStyle(fontFamily: 'Outfit', fontSize: 34, color: Colors.white),
      headlineMedium:
          TextStyle(fontFamily: 'Outfit', fontSize: 30, color: Colors.white),
      headlineSmall:
          TextStyle(fontFamily: 'Outfit', fontSize: 24, color: Colors.white),
      displayMedium:
          TextStyle(fontFamily: 'Outfit', fontSize: 20, color: darkGreen),
      displayLarge:
          TextStyle(fontFamily: 'Outfit', fontSize: 28, color: darkGreen),
      bodyLarge: TextStyle(fontFamily: 'Outfit', fontSize: 24, color: darkGray),
      bodyMedium:
          TextStyle(fontFamily: 'Outfit', fontSize: 16, color: lightGray),
      bodySmall: TextStyle(fontFamily: 'Outfit', fontSize: 16, color: darkGray),
      labelSmall: TextStyle(
          fontFamily: 'Outfit',
          fontSize: 18,
          color: mainYellow,
          fontWeight: FontWeight.bold),
      labelMedium: TextStyle(
          fontFamily: 'Outfit',
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.bold),
      displaySmall: TextStyle(
          fontFamily: 'Outfit',
          fontSize: 18,
          color: mainYellow,
          fontWeight: FontWeight.bold),
      labelLarge: TextStyle(
          fontFamily: 'Outfit',
          fontSize: 24,
          color: Colors.white,
          fontWeight: FontWeight.bold));

  static TextTheme darkTextTheme = const TextTheme(
    titleLarge:
        TextStyle(fontFamily: 'Outfit', fontSize: 44, color: mainYellow),
    titleMedium: TextStyle(fontFamily: 'Outfit', fontSize: 28, color: mainGray),
  );
}
