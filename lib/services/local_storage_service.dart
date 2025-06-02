import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  Future<void> saveUserData({
    required String userId,
    required String email,
    required String name,
    required String surname,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', userId);
    await prefs.setString('email', email);
    await prefs.setString('name', name);
    await prefs.setString('surname', surname);
  }

  Future<Map<String, String?>> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'userId': prefs.getString('userId'),
      'email': prefs.getString('email'),
      'name': prefs.getString('name'),
      'surname': prefs.getString('surname'),
    };
  }

  Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userId');
    await prefs.remove('email');
    await prefs.remove('name');
    await prefs.remove('surname');
  }
}
