import 'package:shared_preferences/shared_preferences.dart';

class PrefService {
  // Sauvegarder le nom de l'utilisateur après une connexion X (Twitter)
  static Future<void> saveUserX(String username) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_x', username);
  }

  // Récupérer le nom sauvegardé
  static Future<String?> getUserX() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_x');
  }

  // Supprimer les données (Logout)
  static Future<void> removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_x');
  }
}