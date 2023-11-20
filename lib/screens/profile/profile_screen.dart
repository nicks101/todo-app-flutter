import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_firebase/providers/auth_provider.dart';
import 'package:todo_firebase/providers/todo_provider.dart';
import 'package:todo_firebase/screens/login/sign_up_screen.dart';
import 'package:todo_firebase/utils/extensions.dart';

import '../../widgets/user_avatar.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final _cityController = TextEditingController();
  final _pinCodeController = TextEditingController();

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, _initControllers);
  }

  void _initControllers() {
    _cityController.text = ref.read(userProvider)?.city ?? '';
    _pinCodeController.text = ref.read(userProvider)?.pinCode ?? '';
  }

  void _updateProfile() {
    _closeKeyboard();

    if (!_areValuesChanged()) return;

    final updatedUser = ref.read(userProvider)?.copyWith(
          city: _cityController.text,
          pinCode: _pinCodeController.text,
        );

    if (updatedUser == null) return;

    try {
      /// A loading state can be shown here
      ref.read(authNotifierProvider.notifier).updateUser(updatedUser).then((_) {
        _showSnackBar('Profile updated successfully');
      });
    } catch (e) {
      _showSnackBar('Failed to update profile');
    }
  }

  bool _areValuesChanged() {
    final user = ref.read(userProvider);

    if (user == null) return false;

    return user.city != _cityController.text ||
        user.pinCode != _pinCodeController.text;
  }

  void _closeKeyboard() {
    FocusScope.of(context).unfocus();
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _logout() {
    ref.read(authNotifierProvider.notifier).signOut();
    ref.read(todoNotifierProvider.notifier).clear();

    context.appNavigator.goToAndRemoveUntil(
      const SignUpScreen(),
      routeName: context.routes.login,
    );
  }

  @override
  void dispose() {
    _cityController.dispose();
    _pinCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const UserAvatar(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              controller: _cityController,
              decoration: const InputDecoration(
                labelText: 'City',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              controller: _pinCodeController,
              decoration: const InputDecoration(
                labelText: 'Pincode',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: const EdgeInsets.all(16.0),
                backgroundColor: context.color.primaryColor,
                foregroundColor: context.color.whiteColor,
              ),
              onPressed: _updateProfile,
              child: const Center(child: Text('Save')),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.all(16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                foregroundColor: Colors.black,
              ),
              onPressed: _logout,
              child: const Center(child: Text('Logout')),
            ),
          ),
        ],
      ),
    );
  }
}
