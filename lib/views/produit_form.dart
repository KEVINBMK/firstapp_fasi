import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProduitForm extends StatefulWidget {
  const ProduitForm({super.key});

  @override
  State<ProduitForm> createState() => _ProduitFormState();
}

class _ProduitFormState extends State<ProduitForm> {
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prixController = TextEditingController();
  bool _isLoading = false;

  Future<void> ajouterProduit() async {
    if (_nomController.text.isNotEmpty && _prixController.text.isNotEmpty) {
      setState(() => _isLoading = true);
      try {
        await FirebaseFirestore.instance.collection('produits').add({
          'nom': _nomController.text,
          'prix': _prixController.text,
          'date': Timestamp.now(),
        });
        if (!mounted) return;
        _nomController.clear();
        _prixController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Produit ajouté !')),
        );
      } finally {
        if (mounted) setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(controller: _nomController, decoration: const InputDecoration(labelText: "Nom")),
        TextField(controller: _prixController, decoration: const InputDecoration(labelText: "Prix"), keyboardType: TextInputType.number),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: _isLoading ? null : ajouterProduit,
          child: _isLoading ? const CircularProgressIndicator() : const Text("Ajouter"),
        ),
      ],
    );
  }
}