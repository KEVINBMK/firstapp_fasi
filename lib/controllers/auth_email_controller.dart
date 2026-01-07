import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth_controller.dart';
import '../services/pref_service.dart';

class AuthEmailController extends AuthController {

  Future<String?> register(BuildContext context, String name, String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email, password: password
      );
      await userCredential.user!.updateDisplayName(name);
      await PrefService.saveUserX(name);
      navigateToHome(context);
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> login(BuildContext context, String email, String password) async {
    try {
      await authService.signInWithEmailAndPassword(email, password);
      navigateToHome(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Erreur Email: $e")));
    }
  }
}