import 'package:flutter/material.dart';
import 'package:todo_firebase/screens/home/todo_list.dart';
import 'package:todo_firebase/screens/profile/profile_screen.dart';
import 'package:todo_firebase/utils/extensions.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All ToDos'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              onTap: () {
                context.appNavigator.goTo(
                  const ProfileScreen(),
                  routeName: context.routes.profile,
                );
              },
              child: CircleAvatar(
                backgroundColor: context.color.transparentColor,
                backgroundImage: const NetworkImage(
                  'https://avatars.githubusercontent.com/u/139426?s=400&u=1f0d0c9b0a0e3b2a0e3b2a0e3b2a0e3b2a0e3b2a&v=4',
                ),
              ),
            ),
          ),
        ],
      ),
      body: const TodoList(),
    );
  }
}
