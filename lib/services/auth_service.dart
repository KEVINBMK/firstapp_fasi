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

  UserModel? _userFromFirebaseUser(User? user) {
    return user != null
        ? UserModel(uid: user.uid, email: user.email, name: user.displayName)
        : null;
  }

  // --- MÉTHODE 1 : INSCRIPTION EMAIL (Manquante dans ton erreur) ---
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

  // --- MÉTHODE 2 : CONNEXION EMAIL (Manquante dans ton erreur) ---
  Future<UserModel?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return _userFromFirebaseUser(result.user);
    } catch (e) {
      debugPrint("Erreur Connexion: $e");
      rethrow;
    }
  }

  // --- MÉTHODE 3 : GOOGLE ---
  Future<UserModel?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      UserCredential result = await _auth.signInWithCredential(credential);
      return _userFromFirebaseUser(result.user);
    } catch (e) {
      debugPrint("Erreur Google: $e");
      return null;
    }
  }

  // --- MÉTHODE 4 : X (Twitter) + Shared Preferences ---
  Future<void> signInWithX(String username) async {
    await PrefService.saveUserX(username);
  }

  // --- MÉTHODE 5 : DÉCONNEXION ---
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await PrefService.removeUser();
    await _auth.signOut();
  }
}