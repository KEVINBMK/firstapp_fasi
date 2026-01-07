import 'package:flutter/material.dart';
import '../controllers/auth_controller.dart';

class LoginEmailView extends StatefulWidget {
  const LoginEmailView({super.key});

  @override
  State<LoginEmailView> createState() => _LoginEmailViewState();
}

class _LoginEmailViewState extends State<LoginEmailView> {
  final AuthController _authController = AuthController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  void _login() async {
    setState(() => _isLoading = true);
    await _authController.login(
      context,
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );
    if (mounted) setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Connexion Email")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: "Email", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Mot de passe", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _login,
                child: _isLoading ? const CircularProgressIndicator() : const Text("Se connecter"),
              ),
            )
          ],
        ),
      ),
    );
  }
}