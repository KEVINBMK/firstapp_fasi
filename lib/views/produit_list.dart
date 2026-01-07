import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProduitList extends StatelessWidget {
  const ProduitList({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('produits')
          .orderBy('date', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('Erreur Firestore'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('Aucun produit'));
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            final doc = snapshot.data!.docs[index];
            final produit = doc.data() as Map<String, dynamic>;

            return ListTile(
              title: Text(produit['nom']),
              subtitle: Text("${produit['prix']} \$"),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => FirebaseFirestore.instance
                    .collection('produits')
                    .doc(doc.id)
                    .delete(),
              ),
            );
          },
        );
      },
    );
  }
}