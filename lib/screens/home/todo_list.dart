import 'package:flutter/material.dart';

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return CheckboxListTile(
          controlAffinity: ListTileControlAffinity.leading,
          title: const Text('Buy milk'),
          value: true,
          onChanged: (value) {},
        );
      },
    );
  }
}
