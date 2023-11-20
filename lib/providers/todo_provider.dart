import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_firebase/core/firebase/firebase_auth_service.dart';
import 'package:todo_firebase/core/firebase/firebase_service.dart';
import 'package:todo_firebase/models/todo_list_state.dart';

import '../models/todo.dart';

part 'todo_provider.g.dart';

@Riverpod(keepAlive: true)
class TodoNotifier extends _$TodoNotifier {
  late final FirebaseApiService _apiService;
  late final FirebaseAuthService _authService;

  @override
  TodoListState build() {
    _apiService = ref.read(firebaseServiceProvider);
    _authService = ref.read(firebaseAuthService);
    return TodoListState();
  }

  Future<void> add(String description) async {
    Todo todo = Todo(
      title: description,
      id: '',
      createdAt: DateTime.now().toIso8601String(),
      updatedAt: DateTime.now().toIso8601String(),
      completed: false,
      userId: _authService.currentUser!.uid,
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
      /// Fail-safe to remove the todo from the list if it fails to add to the database
      if (e is FirebaseException) {
        final index = state.todos.indexOf(todo);
        if (index != -1) {
          final newTodos = [...state.todos];
          newTodos.removeAt(index);
          state = state.copyWith(todos: newTodos);
        }
      }

      /// Custom Exception can be handled here
      rethrow;
    }
  }

  void toggle(Todo todo) {
    final index = state.todos.indexOf(todo);
    final updatedTodo = todo.copyWith(completed: !todo.completed);

    state = state.copyWith(
      todos: [
        for (var i = 0; i < state.todos.length; i++)
          if (i == index) updatedTodo else state.todos[i]
      ],
    );

    try {
      _apiService.updateTodo(updatedTodo);
    } catch (e) {
      /// Fail-safe to remove the todo from the list if it fails to add to the database
      if (e is FirebaseException) {
        final index = state.todos.indexOf(updatedTodo);
        if (index != -1) {
          final newTodos = [...state.todos];
          newTodos.removeAt(index);
          state = state.copyWith(todos: newTodos);
        }
      }
      rethrow;
    }
  }

  Future<void> getAllTodo() async {
    try {
      final userId = _authService.currentUser!.uid;
      final todos = await _apiService.getTodos(userId);
      state = state.copyWith(todos: todos);
    } catch (e) {
      rethrow;
    }
  }

  void clear() {
    state = TodoListState();
  }
}
