import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_firebase/models/todo.dart';

final firebaseServiceProvider = Provider<FirebaseService>((ref) {
  return FirebaseService();
});

class FirebaseService {
  final _db = FirebaseFirestore.instance;

  Future<String> addTodo(Todo todo) async {
    try {
      final docRef =
          _db.collection('users').doc(todo.userId).collection('todos').doc();
      final id = docRef.id;
      final updatedTodo = todo.copyWith(id: id);

      await docRef.set(updatedTodo.toJson());

      return id;
    } catch (e) {
      rethrow;
    }
  }
}
