import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_firebase/core/firebase/firebase_service.dart';
import 'package:todo_firebase/models/todo_list_state.dart';

import '../models/todo.dart';

part 'todo_provider.g.dart';

@Riverpod(keepAlive: true)
class TodoNotifier extends _$TodoNotifier {
  late final FirebaseService _apiService;

  @override
  TodoListState build() {
    _apiService = ref.read(firebaseServiceProvider);
    return TodoListState();
  }

  Future<void> add(String description) async {
    Todo todo = Todo(
      title: description,
      id: '',
      createdAt: DateTime.now().toIso8601String(),
      updatedAt: DateTime.now().toIso8601String(),
      completed: false,
      userId: '1',
    );

    state = state.copyWith(todos: [...state.todos, todo]);
    final index = state.todos.indexOf(todo);

    try {
      final todoId = await _apiService.addTodo(todo);
      todo = todo.copyWith(id: todoId);

      state = state.copyWith(
        todos: [
          for (var i = 0; i < state.todos.length; i++)
            if (i == index) todo else state.todos[i]
        ],
      );
    } catch (e) {
      if (e is FirebaseException) {
        final index = state.todos.indexOf(todo);
        if (index != -1) {
          final newTodos = [...state.todos];
          newTodos.removeAt(index);
          state = state.copyWith(todos: newTodos);
        }
      }
      rethrow;
    }
  }

  void toggle(Todo todo) {
    final index = state.todos.indexOf(todo);
    final newTodos = [...state.todos];
    newTodos[index] = todo.copyWith(completed: !todo.completed);
    state = state.copyWith(todos: newTodos);
  }

  void getAllTodo() {
    state = state.copyWith(todos: todos);
  }
}

final todos = [
  Todo(title: 'Buy milk', id: '1', createdAt: '2021-08-01T12:00:00.000Z'),
  Todo(
      title: 'Buy eggs',
      completed: true,
      id: '2',
      createdAt: '2021-08-02T12:00:00.000Z'),
  Todo(title: 'Buy bread', id: '3', createdAt: '2021-08-03T12:00:00.000Z'),
  Todo(
      title: 'Buy water',
      completed: true,
      id: '4',
      createdAt: '2021-08-04T12:00:00.000Z'),
  Todo(title: 'Buy butter', id: '5', createdAt: '2021-08-05T12:00:00.000Z'),
];
