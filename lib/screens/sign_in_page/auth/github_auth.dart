import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../services/local_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> signInWithGitHub(BuildContext context) async {
  try {
    final githubProvider = OAuthProvider("github.com");
    githubProvider.setScopes(['read:user', 'user:email']);

    final userCredential = await FirebaseAuth.instance.signInWithProvider(githubProvider);

    final storage = LocalStorageService();
    final localUserData = await storage.getUserData();

    String nameToSave;
    if (localUserData['name'] == null || localUserData['name']!.isEmpty) {
      // Local'da isim yoksa GitHub'dan çek
      nameToSave = userCredential.user!.displayName ?? '';
    } else {
      // Local'da isim varsa onu kullan
      nameToSave = localUserData['name']!;
    }

    await storage.saveUserData(
      userId: userCredential.user!.uid,
      email: userCredential.user!.email ?? '',
      name: nameToSave,
      surname: localUserData['surname'] ?? '',
    );

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('welcome_shown', false);

    Navigator.pushNamed(context, '/home');
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("GitHub ile giriş başarısız: $e")));
  }
}
