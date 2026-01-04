import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../models/user_model.dart';
import '../views/home_view.dart';
import '../views/login_view.dart';

class AuthController {
  final AuthService _authService = AuthService();

  // Stream pour suivre l'état de l'utilisateur
  Stream<UserModel?> get userStream => _authService.user;

  // --- INSCRIPTION ---
  Future<String?> register(
      BuildContext context, String name, String email, String password) async {
    try {
      await _authService.registerWithEmailAndPassword(email, password);

      if (!context.mounted) return null;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginView()),
      );
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  // --- CONNEXION EMAIL ---
  Future<String?> login(
      BuildContext context, String email, String password) async {
    try {
      await _authService.signInWithEmailAndPassword(email, password);

      if (!context.mounted) return null;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeView()),
      );
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  // --- CONNEXION GOOGLE ---
  Future<void> loginWithGoogle(BuildContext context) async {
    try {
      await _authService.signInWithGoogle();

      if (!context.mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeView()),
      );
    } catch (e) {
      debugPrint("Erreur Google Controller: $e");
    }
  }

  // --- CONNEXION X (TWITTER) + SHARED PREFERENCES ---
  // Cette méthode manquait et causait ton erreur !
  Future<void> loginWithX(BuildContext context, String username) async {
    try {
      // On utilise le service pour sauvegarder dans les Shared Preferences
      await _authService.signInWithX(username);

      if (!context.mounted) return;

      // Redirection après simulation de connexion réussie
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeView()),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Bienvenue (via X) : $username")),
      );
    } catch (e) {
      debugPrint("Erreur X Controller: $e");
    }
  }

  // --- DÉCONNEXION ---
  Future<void> logout(BuildContext context) async {
    await _authService.signOut();

    if (!context.mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginView()),
          (Route<dynamic> route) => false,
    );
  }

  // Protection d'accès
  Widget handleAuthChanges(BuildContext context, UserModel? user) {
    if (user == null) {
      return const LoginView();
    } else {
      return const HomeView();
    }
  }
}