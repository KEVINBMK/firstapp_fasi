import 'package:flutter/material.dart';
import '../controllers/auth_controller.dart';

class LoginGoogleView extends StatefulWidget {
  const LoginGoogleView({super.key});

  @override
  State<LoginGoogleView> createState() => _LoginGoogleViewState();
}

class _LoginGoogleViewState extends State<LoginGoogleView> {
  final AuthController authController = AuthController();
  bool isLoading = false;

  Future<void> login() async {
    setState(() => isLoading = true);
    try {
      await authController.loginWithGoogle(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Erreur Google: $e")));
    }
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Connexion Google")),
      body: Center(
        child: ElevatedButton(
          onPressed: isLoading ? null : login,
          child: isLoading ? const CircularProgressIndicator(color: Colors.white) : const Text("Se connecter avec Google"),
        ),
      ),
    );
  }
}
