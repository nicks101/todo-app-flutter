import 'package:flutter/material.dart';
import 'package:todo_firebase/core/navigation/app_router.dart';
import 'package:todo_firebase/utils/app_them.dart';

import '../core/navigation/navigation.dart';
import 'app_constants.dart';

extension BuildContextUtils on BuildContext {
  AppNavigator get appNavigator => AppNavigator.of(this);

  AppNavigator get appRootNavigator => AppNavigator.of(this, root: true);

  AppRoutePatterns get routes => AppRoutePatterns();

  ThemeData get _theme => Theme.of(this);

  bool get isLightTheme => _theme.brightness == Brightness.light;

  AppColors get color => isLightTheme ? LightThemeColors() : DarkThemeColors();

  AppTheme get appTheme => AppTheme();

  AppConstants get constants => AppConstants();
}
