import 'package:flutter/material.dart';
import 'auth_controller.dart';

class AuthGoogleController extends AuthController {
  Future<void> loginWithGoogle(BuildContext context) async {
    try {
      await authService.signInWithGoogle();
      navigateToHome(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Erreur Google: $e")));
    }
  }
}