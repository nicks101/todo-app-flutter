import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_firebase/providers/todo_provider.dart';
import 'package:todo_firebase/utils/extensions.dart';

final _todoDescriptionProvider = StateProvider<String>((ref) => '');

class AddTodo extends ConsumerStatefulWidget {
  const AddTodo({super.key});

  @override
  ConsumerState<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends ConsumerState<AddTodo> {
  final _todoController = TextEditingController();

  @override
  void dispose() {
    _todoController.dispose();
    super.dispose();
  }

  void _addNewTodo() {
    final value = ref.read(_todoDescriptionProvider);
    ref.read(todoNotifierProvider.notifier).add(value);
    FocusScope.of(context).unfocus();
    ref.read(_todoDescriptionProvider.notifier).update((_) => '');
    _todoController.clear();
  }

  void _onTodoDescriptionChanged(String value) {
    ref.read(_todoDescriptionProvider.notifier).update((_) => value);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16).copyWith(
        bottom: 16 + MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              maxLines: null,
              controller: _todoController,
              onChanged: _onTodoDescriptionChanged,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(8.0),
                hintText: 'Add a new todo item',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              disabledBackgroundColor: context.color.primaryLightColor,
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            onPressed: ref.watch(_todoDescriptionProvider).isEmpty
                ? null
                : _addNewTodo,
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
