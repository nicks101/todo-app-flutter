import 'package:flutter/material.dart';

class AppNavigator {
  AppNavigator._from(BuildContext context, {bool root = false}) {
    _navigator = Navigator.of(context, rootNavigator: root);
  }

  static AppNavigator of(BuildContext context, {bool root = false}) =>
      AppNavigator._from(
        context,
        root: root,
      );

  late NavigatorState _navigator;

  void goTo(Widget route, {Object? data, String? routeName}) {
    _navigator.push(
      MaterialPageRoute(
        builder: (context) => route,
        settings: RouteSettings(
          name: routeName,
          arguments: data,
        ),
      ),
    );
  }

  void goToReplacement(Widget route, {Object? data, String? routeName}) {
    _navigator.pushReplacement(
      MaterialPageRoute(
        builder: (context) => route,
        settings: RouteSettings(
          name: routeName,
          arguments: data,
        ),
      ),
    );
  }
}
