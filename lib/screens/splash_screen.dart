import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_firebase/providers/todo_provider.dart';
import 'package:todo_firebase/screens/home/home_screen.dart';
import 'package:todo_firebase/utils/extensions.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final animationController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 2),
  );

  late final animation = Tween(
    begin: 0.0,
    end: 1.0,
  ).animate(animationController);

  @override
  void initState() {
    super.initState();
    animationController.forward();
    animationController.addStatusListener(_animationListener);

    // if logged in
    Future.delayed(Duration.zero, _getAllTodos);
  }

  void _getAllTodos() async {
    ref.read(todoNotifierProvider.notifier).getAllTodo();
  }

  void _animationListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) _goToNextScreen();
  }

  void _goToNextScreen() {
    context.appNavigator.goToReplacement(
      const HomeScreen(),
      routeName: context.routes.home,
    );
  }

  @override
  void dispose() {
    animationController.removeStatusListener(_animationListener);
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.color.primaryLightColor,
      body: Center(
        child: FadeTransition(
          opacity: animationController,
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: context.color.primaryColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Icon(
                Icons.check,
                color: context.color.primaryLightColor,
                size: 40,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
