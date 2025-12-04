import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../models/user_model.dart';
import '../views/home_view.dart';
import '../views/login_view.dart';

class AuthController {
  final AuthService _authService = AuthService();

  // Stream pour suivre l'état de l'utilisateur
  Stream<UserModel?> get userStream => _authService.user;

  // Inscription
  Future<String?> register(
      BuildContext context, String name, String email, String password) async {
    try {
      await _authService.registerWithEmailAndPassword(email, password);
      // Après inscription, on redirige vers la page de connexion comme demandé
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginView()),
      );
      return null; // Succès
    } catch (e) {
      return e.toString(); // Échec
    }
  }

  // Connexion
  Future<String?> login(
      BuildContext context, String email, String password) async {
    try {
      await _authService.signInWithEmailAndPassword(email, password);
      // Après connexion, on redirige vers la page d'accueil
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeView()),
      );
      return null; // Succès
    } catch (e) {
      return e.toString(); // Échec
    }
  }

  // Déconnexion
  Future<void> logout(BuildContext context) async {
    await _authService.signOut();
    // Après déconnexion, on redirige vers la page de connexion
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginView()),
      (Route<dynamic> route) => false,
    );
  }

  // Protection d'accès : vérifie si l'utilisateur est connecté et redirige si nécessaire
  Widget handleAuthChanges(BuildContext context, UserModel? user) {
    if (user == null) {
      // Si l'utilisateur n'est pas connecté, on le renvoie vers Login
      return const LoginView();
    } else {
      // Si l'utilisateur est connecté, on le renvoie vers Home
      return const HomeView();
    }
  }
}
