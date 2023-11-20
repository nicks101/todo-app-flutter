import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_firebase/core/firebase/firebase_service.dart';
import 'package:todo_firebase/models/user_model.dart';

import '../core/firebase/firebase_auth_service.dart';

part 'auth_provider.g.dart';

final userProvider = StateProvider<UserModel?>((ref) => null);

@Riverpod(keepAlive: true)
class AuthNotifier extends _$AuthNotifier {
  late final FirebaseAuthService _firebaseAuthService;
  late final FirebaseApiService _firebaseApiService;

  @override
  void build() {
    _firebaseAuthService = ref.read(firebaseAuthService);
    _firebaseApiService = ref.read(firebaseServiceProvider);

    return;
  }

  bool isLoggedIn() {
    return _firebaseAuthService.isLoggedIn();
  }

  Future<void> signOut() async {
    await _firebaseAuthService.signOut();
  }

  Future<void> syncUser() async {
    await addUser();
    await getUser();
  }

  Future<void> getUser() async {
    final userId = _firebaseAuthService.currentUser?.uid;
    if (userId == null) return;

    final user = await _firebaseApiService.getUser(userId);

    if (user != null) {
      ref.read(userProvider.notifier).update((state) => user);
    }
  }

  Future<void> addUser() async {
    final user = _firebaseAuthService.currentUser;
    if (user == null) return;
    final newUser = UserModel.fromFirebaseUser(user);
    await _firebaseApiService.updateUser(
      newUser.id,
      newUser.fromFirebaseUserToMap(user),
    );
  }

  Future<void> updateUser(UserModel user) async {
    await _firebaseApiService.updateUser(user.id, user.toJson());
    ref.read(userProvider.notifier).update((state) => user);
  }
}
