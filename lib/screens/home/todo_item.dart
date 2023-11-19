import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/todo.dart';
import '../../providers/todo_provider.dart';

final currentTodo = Provider<Todo>((ref) => throw UnimplementedError());

class TodoItem extends ConsumerStatefulWidget {
  // const TodoItem(this.todo, {super.key});

  // final Todo todo;

  const TodoItem({super.key});

  @override
  ConsumerState<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends ConsumerState<TodoItem> {
  Todo get todo => ref.watch(currentTodo);

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      controlAffinity: ListTileControlAffinity.leading,
      title: Text(
        todo.title,
        style: TextStyle(
          decoration: todo.completed ? TextDecoration.lineThrough : null,
        ),
      ),
      value: todo.completed,
      onChanged: (value) {
        if (value == null) return;
        ref.read(todoNotifierProvider.notifier).toggle(todo);
      },
    );
  }
}
