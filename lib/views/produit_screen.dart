import 'package:flutter/material.dart';
import 'produit_form.dart';
import 'produit_list.dart';

class ProduitScreen extends StatelessWidget {
  const ProduitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ma Boutique")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: const [
            ProduitForm(), // Le formulaire en haut
            Divider(height: 40),
            Expanded(child: ProduitList()), // La liste en bas
          ],
        ),
      ),
    );
  }
}