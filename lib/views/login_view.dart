import 'package:flutter/material.dart';
import 'login_email_view.dart';
import 'login_google_view.dart';
import 'login_x_view.dart';
import 'register_view.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Connexion")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // BOUTON EMAIL
            ElevatedButton.icon(
              icon: const Icon(Icons.email_outlined),
              label: const Text("Se connecter avec Email"),
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginEmailView())
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
            const SizedBox(height: 15),

            // BOUTON GOOGLE
            ElevatedButton.icon(
              icon: const Icon(Icons.g_mobiledata, size: 30, color: Colors.red),
              label: const Text("Se connecter avec Google"),
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginGoogleView())
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                backgroundColor: Colors.white,
                foregroundColor: Colors.black, // Texte en noir pour le style Google
                side: const BorderSide(color: Colors.black12),
              ),
            ),
            const SizedBox(height: 15),

            // BOUTON X (Twitter)
            ElevatedButton.icon(
              icon: const Icon(Icons.close, size: 20), // Le "X"
              label: const Text("Se connecter avec X"),
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginXView())
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
              ),
            ),

            const SizedBox(height: 30),

            // SECTION INSCRIPTION
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Pas de compte ?"),
                TextButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const RegisterView())
                  ),
                  child: const Text(
                    "S'inscrire ici",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}