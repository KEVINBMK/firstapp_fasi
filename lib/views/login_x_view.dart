import 'package:flutter/material.dart';
import '../controllers/auth_controller.dart';

class LoginXView extends StatefulWidget {
  const LoginXView({super.key});

  @override
  State<LoginXView> createState() => _LoginXViewState();
}

class _LoginXViewState extends State<LoginXView> {
  final AuthController _authController = AuthController();
  final TextEditingController _usernameController = TextEditingController();
  bool _isLoading = false;

  void _handleXLogin() async {
    if (_usernameController.text.isEmpty) return;

    setState(() => _isLoading = true);
    // Utilisation du contrôleur que tu as fourni
    await _authController.loginWithX(context, _usernameController.text.trim());

    if (mounted) setState(() => _isLoading = false);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Connexion X")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.close, size: 80, color: Colors.black),
            const SizedBox(height: 20),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: "Nom d'utilisateur X",
                border: OutlineInputBorder(),
                prefixText: "@ ",
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black, foregroundColor: Colors.white),
                onPressed: _isLoading ? null : _handleXLogin,
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Se connecter avec X"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}