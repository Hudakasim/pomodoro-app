import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../services/local_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> signInWithGitHub(BuildContext context) async {
  try {
    final githubProvider = OAuthProvider("github.com");
    githubProvider.setScopes(['read:user', 'user:email']);

    final userCredential = await FirebaseAuth.instance.signInWithProvider(githubProvider);

    // SharedPreferences'a kayıt
    final storage = LocalStorageService();
    await storage.saveUserData(
      userId: userCredential.user!.uid,
      email: userCredential.user!.email ?? '',
      name: userCredential.user!.displayName ?? '',
      surname: '',
    );
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('welcome_shown', false);

    Navigator.pushNamed(context, '/home');
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("GitHub ile giriş başarısız: $e")));
  }
}

