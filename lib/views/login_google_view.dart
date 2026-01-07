import 'package:flutter/material.dart';
// Importation du contrôleur spécialisé
import '../controllers/auth_google_controller.dart';

class LoginGoogleView extends StatefulWidget {
  const LoginGoogleView({super.key});

  @override
  State<LoginGoogleView> createState() => _LoginGoogleViewState();
}

class _LoginGoogleViewState extends State<LoginGoogleView> {
  // Utilisation du contrôleur spécifique pour Google
  final AuthGoogleController authController = AuthGoogleController();
  bool isLoading = false;

  Future<void> login() async {
    setState(() => isLoading = true);

    try {
      // On utilise la méthode du contrôleur spécialisé
      await authController.loginWithGoogle(context);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erreur Google: $e")),
        );
      }
    } finally {
      // On remet l'état à false même s'il y a une erreur
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Connexion Google")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Style simple avec une icône standard
              const Icon(Icons.account_circle, size: 100, color: Colors.blueGrey),
              const SizedBox(height: 20),
              const Text(
                "Connexion via Google",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                "Veuillez utiliser votre compte Google pour vous authentifier.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 40),

              // Bouton standard
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    side: const BorderSide(color: Colors.black12),
                  ),
                  onPressed: isLoading ? null : login,
                  icon: isLoading
                      ? const SizedBox.shrink() // Remplace le .none qui n'existe pas
                      : const Icon(Icons.g_mobiledata, color: Colors.red, size: 30),
                  label: isLoading
                      ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                      : const Text("Se connecter avec Google"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}