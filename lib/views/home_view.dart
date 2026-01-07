import 'package:flutter/material.dart';
import '../controllers/auth_controller.dart';
import '../services/pref_service.dart';
import 'produit_screen.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = AuthController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Mon Dashboard"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => authController.logout(context),
          )
        ],
      ),
      body: Column(
        children: [
          // -----------------------------
          // Section Bienvenue avec SharedPreferences
          // -----------------------------
          Container(
            padding: const EdgeInsets.all(20),
            color: Colors.deepPurple.withOpacity(0.1),
            child: FutureBuilder<String?>(
              future: PrefService.getUserX(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Row(
                    children: const [
                      CircleAvatar(child: Icon(Icons.person)),
                      SizedBox(width: 15),
                      Text(
                        "Chargement...",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  );
                }

                // Nom de l'utilisateur ou valeur par défaut
                final String name = snapshot.data?.isNotEmpty == true
                    ? snapshot.data!
                    : "Utilisateur";

                return Row(
                  children: [
                    const CircleAvatar(child: Icon(Icons.person)),
                    const SizedBox(width: 15),
                    Text(
                      "Bienvenue, $name !",
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                );
              },
            ),
          ),

          const SizedBox(height: 10),

          // -----------------------------
          // Grille de navigation
          // -----------------------------
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.all(20),
              childAspectRatio: 1, // cartes carrées
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              children: [
                _menuItem(context, "Produits", Icons.shopping_cart, Colors.orange, const ProduitScreen()),
                _menuItem(context, "Profil", Icons.badge, Colors.blue, null),
                _menuItem(context, "Ventes", Icons.trending_up, Colors.green, null),
                _menuItem(context, "Réglages", Icons.settings, Colors.grey, null),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // -----------------------------
  // Widget pour chaque carte de menu
  // -----------------------------
  Widget _menuItem(BuildContext context, String title, IconData icon, Color color, Widget? page) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          if (page != null) {
            Navigator.push(context, MaterialPageRoute(builder: (_) => page));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('$title en cours de développement')),
            );
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
