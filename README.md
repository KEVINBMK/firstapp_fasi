# ToutFasi App - TP Flutter Firebase Auth

Ce projet est un **Travail Pratique (TP) Flutter** qui implémente un système d'authentification complet (Inscription, Connexion, Déconnexion) en utilisant **Firebase Authentication**.

---

## Réalisé par
**Nom :** Kevin Bitubisha Mbemba  
**Filière :** L4LMD FASI  
**Statut :** Travail Terminé et Validé  

---

## Objectifs du TP Atteints

1. **Inscription (Register)** : Création de compte avec nom, email et mot de passe, validation des champs, et utilisation de `createUserWithEmailAndPassword`.  
2. **Connexion (Login)** : Connexion avec email et mot de passe, et utilisation de `signInWithEmailAndPassword`.  
3. **Page Home** : Accessible uniquement aux utilisateurs connectés, affichant un message de bienvenue.  
4. **Protection d'Accès** : Redirection automatique vers la page de connexion si l'utilisateur n'est pas authentifié (géré par le `Wrapper` dans `main.dart`).  
5. **Organisation du Code** : Structure claire en `controllers/`, `services/`, `views/`, `models/`, `widgets/`, et `utils/`.  



## Étapes de Configuration Validées

Le projet a été configuré avec succès pour l'intégration **Firebase** :

* **Dépendances** : Ajout de `firebase_core`, `firebase_auth` et `provider` via `flutter pub add`.  
* **Configuration Android** : Fichier `google-services.json` placé dans `android/app/` et modifications des fichiers Gradle (`android/build.gradle` et `android/app/build.gradle`) effectuées en utilisant la syntaxe moderne.  
* **Firebase Console** : Le fournisseur d'authentification **Email/Password** a été activé.  

