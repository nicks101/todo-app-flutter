import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_firebase/screens/home/todo_item.dart';

import '../../providers/todo_provider.dart';

class TodoList extends ConsumerWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoNotifierProvider).todos;

    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final todo = todos[index];
        return ProviderScope(
          overrides: [currentTodo.overrideWithValue(todo)],
          // child: TodoItem(todo),
          child: const TodoItem(),
        );
      },
    );
  }
}
