import 'package:flutter/material.dart';
import 'login_email_view.dart';
import 'login_x_view.dart';
import '../controllers/auth_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  // On initialise le contrôleur ici
  final AuthController _authController = AuthController();
  bool _isGoogleLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Connexion"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // --- CONNEXION EMAIL ---
            ElevatedButton.icon(
              icon: const Icon(Icons.email),
              label: const Text("Se connecter avec Email"),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LoginEmailView()),
              ),
            ),
            const SizedBox(height: 15),

            // --- CONNEXION GOOGLE ---
            // On n'ouvre pas de page, on appelle directement le service
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.red),
                foregroundColor: Colors.red,
              ),
              icon: _isGoogleLoading
                  ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.red))
                  : const Icon(Icons.g_mobiledata, size: 30),
              label: const Text("Continuer avec Google"),
              onPressed: _isGoogleLoading ? null : () async {
                setState(() => _isGoogleLoading = true);
                await _authController.loginWithGoogle(context);
                if (mounted) setState(() => _isGoogleLoading = false);
              },
            ),
            const SizedBox(height: 15),

            // --- CONNEXION X ---
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
              ),
              icon: const Icon(Icons.close), // Icône X
              label: const Text("Se connecter avec X"),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LoginXView()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}