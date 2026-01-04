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
          // Section Bienvenue (Créativité : Récupération SharedPrefs)
          Container(
            padding: const EdgeInsets.all(20),
            color: Colors.deepPurple.withOpacity(0.1),
            child: FutureBuilder<String?>(
              future: PrefService.getUserX(),
              builder: (context, snapshot) {
                String name = snapshot.data ?? "Utilisateur";
                return Row(
                  children: [
                    const CircleAvatar(child: Icon(Icons.person)),
                    const SizedBox(width: 15),
                    Text("Bienvenue, $name !", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                );
              },
            ),
          ),

          // Grille de navigation
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.all(20),
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

  Widget _menuItem(BuildContext context, String title, IconData icon, Color color, Widget? page) {
    return Card(
      child: InkWell(
        onTap: () {
          if (page != null) Navigator.push(context, MaterialPageRoute(builder: (context) => page));
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(height: 10),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}