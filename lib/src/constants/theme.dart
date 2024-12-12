import 'package:flutter/material.dart';
import 'textTheme.dart';

class AppTheme {
  static const mainGreen = Color(0xFF4CB963);
  static const darkGreen = Color(0xFF379237);
  static const mainYellow = Color(0xFFFDD849);
  static const mainGray = Color(0xFF737F84);
  static const lightGray = Color(0xFFC7CBCD);
  static const mainRed = Color(0xFFfd4949);
  static const mainWhite = Color(0xFFFFFFFF);
  static const mainBlack = Color(0xFF333333);
  static const noteYellow = Color(0xFFfdd849);

  static ThemeData lightTheme = ThemeData(
      brightness: Brightness.light, textTheme: TextAppTheme.lightTextTheme);

  static ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark, textTheme: TextAppTheme.lightTextTheme);
}
