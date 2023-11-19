import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_firebase/providers/auth_provider.dart';
import 'package:todo_firebase/providers/todo_provider.dart';
import 'package:todo_firebase/screens/login/sign_up_screen.dart';
import 'package:todo_firebase/utils/extensions.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            const Text('Profile Screen'),
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.black),
              onPressed: () {
                ref.read(authNotifierProvider.notifier).signOut();
                ref.read(todoNotifierProvider.notifier).clear();

                context.appNavigator.goToAndRemoveUntil(
                  const SignUpScreen(),
                  routeName: context.routes.login,
                );
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
