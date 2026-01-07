import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../models/user_model.dart';
import '../views/login_view.dart';
import '../views/home_view.dart';

class AuthController {
  final AuthService authService = AuthService();

  Stream<UserModel?> get userStream => authService.user;

  // Navigation commune
  void navigateToHome(BuildContext context) {
    if (!context.mounted) return;
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeView()));
  }

  // Déconnexion (commune à tous)
  Future<void> logout(BuildContext context) async {
    await authService.signOut();
    if (!context.mounted) return;
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const LoginView()),
            (route) => false
    );
  }

  Widget handleAuthChanges(UserModel? user) {
    return user == null ? const LoginView() : const HomeView();
  }
}