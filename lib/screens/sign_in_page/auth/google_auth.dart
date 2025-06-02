import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import '../../../services/local_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future<void> signInWithGoogle(BuildContext context) async {
  try {
    final googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) return;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

    final storage = LocalStorageService();
    final userId = userCredential.user!.uid;

    // userId bazlı local veriyi al
    final localUserData = await storage.getUserData(userId);

    String nameToSave;
    if (localUserData['name'] == null || localUserData['name']!.isEmpty) {
      // Local'da kullanıcıya özel isim yoksa Google'dan al
      nameToSave = userCredential.user!.displayName ?? '';
    } else {
      // Varsa localdeki ismi kullan
      nameToSave = localUserData['name']!;
    }

    await storage.saveUserData(
      userId: userId,
      email: userCredential.user!.email ?? '',
      name: nameToSave,
      surname: localUserData['surname'] ?? '',
    );

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('welcome_shown', false);

    Navigator.pushNamed(context, '/home');
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Google ile giriş başarısız: $e")));
  }
}


