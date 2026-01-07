import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/pref_service.dart';
import '../services/auth_service.dart';
import '../models/user_model.dart';
import '../views/home_view.dart';
import '../views/login_view.dart';

class AuthController {
  final AuthService _authService = AuthService();

  // Stream pour suivre l'état de l'utilisateur
  Stream<UserModel?> get userStream => _authService.user;

  // --- INSCRIPTION EMAIL ---
  Future<String?> register(
      BuildContext context,
      String name,
      String email,
      String password,
      ) async {
    try {
      UserCredential userCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // 1️⃣ Enregistrer le nom dans Firebase Auth
      await userCredential.user!.updateDisplayName(name);

      // 2️⃣ Enregistrer le nom dans SharedPreferences
      await PrefService.saveUserX(name);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeView()),
      );
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  // --- CONNEXION EMAIL ---
  Future<void> login(BuildContext context, String email, String password) async {
    try {
      final user = await _authService.signInWithEmailAndPassword(email, password);

      if (!context.mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeView()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erreur connexion: $e")),
      );
    }
  }

  // --- CONNEXION GOOGLE ---
  Future<void> loginWithGoogle(BuildContext context) async {
    try {
      final user = await _authService.signInWithGoogle();

      if (!context.mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeView()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erreur Google: $e")),
      );
    }
  }

  // --- CONNEXION X (TWITTER) ---
  Future<void> loginWithX(BuildContext context, String username) async {
    try {
      final user = await _authService.signInWithX(username);

      if (!context.mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeView()),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Bienvenue via X : ${user.name}")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erreur X: $e")),
      );
    }
  }

  // --- DÉCONNEXION ---
  Future<void> logout(BuildContext context) async {
    await _authService.signOut();

    if (!context.mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginView()),
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
