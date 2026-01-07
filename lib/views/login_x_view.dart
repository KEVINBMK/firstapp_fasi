import 'package:flutter/material.dart';
import '../controllers/auth_x_controller.dart';

class LoginXView extends StatefulWidget {
  const LoginXView({super.key});

  @override
  State<LoginXView> createState() => _LoginXViewState();
}

class _LoginXViewState extends State<LoginXView> {
  final AuthXController authController = AuthXController();
  final usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Connexion X")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: usernameController, decoration: const InputDecoration(labelText: "Nom d'utilisateur X")),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => authController.loginWithX(context, usernameController.text),
              child: const Text("Continuer avec X"),
            ),
          ],
        ),
      ),
    );
  }
}