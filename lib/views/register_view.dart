import 'package:flutter/material.dart';
import '../controllers/auth_controller.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = AuthController();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text("Créer un compte")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(controller: nameController, decoration: const InputDecoration(labelText: "Nom complet")),
            TextField(controller: emailController, decoration: const InputDecoration(labelText: "Email")),
            TextField(controller: passwordController, decoration: const InputDecoration(labelText: "Mot de passe"), obscureText: true),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                String? error = await authController.register(
                    context,
                    nameController.text,
                    emailController.text,
                    passwordController.text
                );
                if (error != null && context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
                }
              },
              child: const Text("S'inscrire"),
            ),
          ],
        ),
      ),
    );
  }
}