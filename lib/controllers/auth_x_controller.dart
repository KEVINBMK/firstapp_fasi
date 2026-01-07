import 'package:flutter/material.dart';
import 'auth_controller.dart';

class AuthXController extends AuthController {
  Future<void> loginWithX(BuildContext context, String username) async {
    try {
      final user = await authService.signInWithX(username);
      navigateToHome(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Bienvenue @${user.name}")));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Erreur X: $e")));
    }
  }
}