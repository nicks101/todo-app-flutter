import 'package:todo_firebase/models/todo.dart';

class TodoListState {
  final List<Todo> todos;

  TodoListState({this.todos = const []});

  TodoListState copyWith({List<Todo>? todos}) {
    return TodoListState(
      todos: todos ?? this.todos,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TodoListState && other.todos == todos;
  }

  @override
  int get hashCode => todos.hashCode;

  @override
  String toString() => 'TodoListState(todos: ${todos.length})';
}
