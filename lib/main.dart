import 'package:firstapp_fasi/views/register_view.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart'; // Utilisation de Provider pour le stream d\'auth simple
import 'models/user_model.dart';
import 'services/auth_service.dart';
import 'controllers/auth_controller.dart';
import 'views/login_view.dart';
import 'views/home_view.dart';

// La page principale qui gère la redirection
class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    // Écoute le changement d\'état de l\'utilisateur
    final user = Provider.of<UserModel?>(context);
    final AuthController authController = AuthController();

    // Protection d\'accès
    // Si l\'utilisateur est null (déconnecté), on affiche LoginView.
    // Sinon (connecté), on affiche HomeView.
    if (user == null) {
      return const LoginView();
    } else {
      return const HomeView();
    }
  }
}

// Initialisation de Firebase et de l\'application
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Utilisation de StreamProvider pour écouter l\'état de l\'utilisateur
    // C\'est le moyen le plus simple de gérer l\'état d\'authentification sans
    // utiliser de "state management avancé" comme GetX ou Bloc.
    return StreamProvider<UserModel?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ToutFasi App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        // On utilise la page Wrapper comme page d\'accueil pour gérer la redirection
        home: const Wrapper(),
        // Définition des routes simples (bien que non utilisées directement avec Navigator.pushReplacement)
        routes: {
          '/login': (context) => const LoginView(),
          '/register': (context) => const RegisterView(),
          '/home': (context) => const HomeView(),
        },
      ),
    );
  }
}
