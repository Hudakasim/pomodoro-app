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
    await prefs.setString('name_$userId', name);
    await prefs.setString('surname_$userId', surname);
  }

  Future<Map<String, String?>> getUserData(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'userId': prefs.getString('userId'),
      'email': prefs.getString('email'),
      'name': prefs.getString('name_$userId'),
      'surname': prefs.getString('surname_$userId'),
    };
  }

  Future<void> updateName(String userId, String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name_$userId', name);
  }

  Future<void> updateSurname(String userId, String surname) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('surname_$userId', surname);
  }
}


