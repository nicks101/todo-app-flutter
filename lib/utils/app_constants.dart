import 'package:flutter/painting.dart';

abstract class AppColors {
  Color get blackColor => const Color(0xFF000000);
  Color get whiteColor => const Color(0xFFFFFFFF);
  Color get primaryColor => const Color(0xFF461AC8);
  Color get primaryLightColor => const Color(0xFFDCD2F9);
  Color get transparentColor => const Color(0x00000000);
}

class LightThemeColors extends AppColors {}

class DarkThemeColors extends AppColors {}

class AppConstants {
  String get defaultProfilePicPath =>
      'https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_1280.png';
}
