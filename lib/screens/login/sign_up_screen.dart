import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_firebase/providers/auth_provider.dart';
import 'package:todo_firebase/providers/todo_provider.dart';
import 'package:todo_firebase/utils/extensions.dart';

import '../home/home_screen.dart';

class SignUpScreen extends ConsumerWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SignInScreen(
        showPasswordVisibilityToggle: true,
        actions: [
          AuthStateChangeAction<SignedIn>((context, state) {
            ref.read(authNotifierProvider.notifier).syncUser().then((_) {
              ref.read(todoNotifierProvider.notifier).getAllTodo();
              context.appNavigator.goToAndRemoveUntil(
                const HomeScreen(),
                routeName: context.routes.home,
              );
            });
          }),
        ],
      ),
    );
  }
}
