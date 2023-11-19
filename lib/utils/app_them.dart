import 'package:flutter/material.dart';
import 'package:todo_firebase/utils/app_constants.dart';

class AppTheme {
  static final AppColors _lightColors = LightThemeColors();
  static final AppColors _darkColors = DarkThemeColors();

  ThemeData lightTheme = ThemeData(
    primaryColorDark: _darkColors.primaryColor,
    brightness: Brightness.light,
    primaryColor: _lightColors.primaryColor,
    textTheme: const TextTheme(),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: _lightColors.whiteColor,
        backgroundColor: _lightColors.primaryColor,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(_lightColors.whiteColor),
      ),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: _lightColors.primaryColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
      focusColor: _lightColors.primaryColor,
    ),
    iconTheme: IconThemeData(
      color: _lightColors.whiteColor,
    ),
    colorScheme: ColorScheme.light(
      primary: _lightColors.primaryColor,
      brightness: Brightness.light,
    ),
  );

  ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: _darkColors.primaryColor,
    textTheme: const TextTheme(),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: _darkColors.whiteColor,
        backgroundColor: _darkColors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        minimumSize: const Size(164, 58),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(_darkColors.blackColor),
      ),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: _darkColors.primaryColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
      focusColor: _darkColors.primaryColor,
    ),
    colorScheme: ColorScheme.dark(
      primary: _darkColors.primaryColor,
    ),
  );
}
