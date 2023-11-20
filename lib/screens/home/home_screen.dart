import 'package:flutter/material.dart';
import 'package:todo_firebase/screens/home/add_todo.dart';
import 'package:todo_firebase/screens/home/todo_list.dart';
import 'package:todo_firebase/screens/profile/profile_screen.dart';
import 'package:todo_firebase/utils/extensions.dart';

import '../../widgets/user_avatar.dart';

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
              child: const UserAvatar(),
            ),
          ),
        ],
      ),
      body: const TodoList(),
      bottomNavigationBar: const AddTodo(),
    );
  }
}
