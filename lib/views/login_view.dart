import 'package:flutter/material.dart';
import '../controllers/auth_controller.dart';
import 'register_view.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = AuthController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text("Connexion")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Icon(Icons.lock_outline, size: 80, color: Colors.deepPurple),
              const SizedBox(height: 20),
              TextField(controller: emailController, decoration: const InputDecoration(labelText: "Email")),
              TextField(controller: passwordController, decoration: const InputDecoration(labelText: "Mot de passe"), obscureText: true),
              const SizedBox(height: 20),

              // Bouton Email
              ElevatedButton(
                onPressed: () => authController.login(context, emailController.text, passwordController.text),
                child: const Text("Se connecter"),
              ),

              const Divider(height: 40),

              // Bouton Google
              ListTile(
                leading: const Icon(Icons.android, color: Colors.green),
                title: const Text("Continuer avec Google"),
                onTap: () => authController.loginWithGoogle(context),
                tileColor: Colors.grey[200],
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),

              const SizedBox(height: 10),

              // Bouton X (Twitter)
              ListTile(
                leading: const Icon(Icons.close, color: Colors.black), // Logo X
                title: const Text("Continuer avec X"),
                onTap: () {
                  // On simule l'auth X avec un username fixe pour le TP
                  authController.loginWithX(context, "Utilisateur_X");
                },
                tileColor: Colors.grey[200],
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),

              TextButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterView())),
                child: const Text("Pas de compte ? S'inscrire"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}