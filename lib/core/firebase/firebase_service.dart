import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_firebase/models/todo.dart';
import 'package:todo_firebase/models/user_model.dart';

final firebaseServiceProvider = Provider<FirebaseApiService>((ref) {
  return FirebaseApiService();
});

class FirebaseApiService {
  final _db = FirebaseFirestore.instance;

  Future<String> addTodo(Todo todo) async {
    try {
      final docRef =
          _db.collection('users').doc(todo.userId).collection('todos').doc();
      final id = docRef.id;
      final updatedTodo = todo.copyWith(id: id);
      await docRef.set(updatedTodo.toJson(), SetOptions(merge: true));
      return id;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Todo>> getTodos(String userId) async {
    try {
      final snapshot = await _db
          .collection('users')
          .doc(userId)
          .collection('todos')
          .orderBy('createdAt', descending: true)
          .limit(200)
          .get();

      return snapshot.docs
          .map((doc) => Todo.fromJson(doc.data()))
          .toList(growable: false);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateTodo(Todo todo) async {
    try {
      final docRef = _db
          .collection('users')
          .doc(todo.userId)
          .collection('todos')
          .doc(todo.id);
      await docRef.set(todo.toJson(), SetOptions(merge: true));
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateUser(String userId, Map<String, dynamic> user) async {
    try {
      final docRef = _db.collection('users').doc(userId);
      await docRef.set(user, SetOptions(merge: true));
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel?> getUser(String id) async {
    try {
      final docRef = _db.collection('users').doc(id);
      final snapshot = await docRef.get();
      if (!snapshot.exists) return null;
      return UserModel.fromJson(snapshot.data() ?? {});
    } catch (e) {
      rethrow;
    }
  }
}
