import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/user_model.dart';
import 'pref_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Stream pour l'état de l'utilisateur
  Stream<UserModel?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  // Convertir Firebase User en UserModel
  UserModel? _userFromFirebaseUser(User? user) {
    return user != null
        ? UserModel(uid: user.uid, email: user.email, name: user.displayName)
        : null;
  }

  // --- INSCRIPTION EMAIL ---
  Future<UserModel?> registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return _userFromFirebaseUser(result.user);
    } catch (e) {
      debugPrint("Erreur Inscription: $e");
      rethrow;
    }
  }

  // --- CONNEXION EMAIL ---
  Future<UserModel?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      // Sauvegarde du displayName dans SharedPreferences
      if (result.user != null && result.user!.displayName != null) {
        await PrefService.saveUserX(result.user!.displayName!);
      }

      return _userFromFirebaseUser(result.user);
    } catch (e) {
      debugPrint("Erreur Connexion: $e");
      rethrow;
    }
  }

  // --- GOOGLE SIGN-IN ---
  Future<UserModel?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential result = await _auth.signInWithCredential(credential);

      // Sauvegarde du displayName dans SharedPreferences
      if (result.user != null && result.user!.displayName != null) {
        await PrefService.saveUserX(result.user!.displayName!);
      }

      return _userFromFirebaseUser(result.user);
    } catch (e) {
      debugPrint("Erreur Google: $e");
      return null;
    }
  }

  // --- X (Twitter) + SharedPreferences ---
  Future<UserModel> signInWithX(String username) async {
    await PrefService.saveUserX(username); // sauvegarde local
    return UserModel(uid: 'x_$username', email: null, name: username);
  }

  // --- DÉCONNEXION ---
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();       // Google sign out
      await PrefService.removeUser();      // Supprimer user X
      await _auth.signOut();               // Firebase sign out
    } catch (e) {
      debugPrint("Erreur Déconnexion: $e");
    }
  }
}
