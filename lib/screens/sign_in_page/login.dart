import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../services/local_storage_service.dart';
import 'register.dart';
import 'auth/google_auth.dart';
import 'auth/github_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/user_service.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final UserService _userService = UserService();
  final LocalStorageService _localStorage = LocalStorageService();

  bool _isLoading = false;

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _usernameController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Kullanıcı bilgilerini SharedPreferences'e kaydet
      await _localStorage.saveUserData(
        userId: userCredential.user!.uid,
        email: userCredential.user!.email ?? '',
        name: userCredential.user!.displayName ?? userCredential.user!.email!.split('@')[0],
        surname: '',
      );

      // Firestore'a kullanıcı bilgisi kaydet (varsa güncelle)
      await _userService.updateUserProfile(
        '', // Doğum tarihi (boş bırakıldı)
        '', // Doğum yeri (boş bırakıldı)
        '', // Şehir (boş bırakıldı)
      );

      // Hoşgeldin mesajı için flag sıfırlama
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('welcome_shown', false);

      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Sign-in error: ${e.toString()}")),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFC31F48),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(50, 0, 50, 150),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo/logo.png', height: 100),
            const Text(
              "Welcome to MindTick!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 50),

            // Email TextField
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: "User Name",
                labelStyle: const TextStyle(color: Colors.black),
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 2.0),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                hintText: "Enter Your Email",
                hintStyle: const TextStyle(fontSize: 13),
              ),
              keyboardType: TextInputType.emailAddress,
            ),

            const SizedBox(height: 20),

            // Password TextField
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: "Password",
                labelStyle: const TextStyle(color: Colors.black),
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 2.0),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                hintText: "Enter Your Password",
                hintStyle: const TextStyle(fontSize: 13),
              ),
              obscureText: true,
            ),

            const SizedBox(height: 50),

            // Login Button
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFC31F48),
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                    onPressed: _login,
                    child: const Text("Login", style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),

            const SizedBox(height: 20),

            // Register Link
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account?"),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const RegisterPage()),
                    );
                  },
                  child: const Text("Register with Mail", style: TextStyle(color: Colors.pink)),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // Google + GitHub Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Google
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: Colors.grey),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                  onPressed: () => signInWithGoogle(context),
                  child: Row(
                    children: [
                      Image.asset('assets/images/google.png', height: 20),
                      const SizedBox(width: 8),
                      const Text("Google", style: TextStyle(color: Colors.black)),
                    ],
                  ),
                ),
                const SizedBox(width: 12),

                // GitHub
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: Colors.grey),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                  onPressed: () => signInWithGitHub(context),
                  child: Row(
                    children: [
                      Image.asset('assets/images/github.png', height: 20),
                      const SizedBox(width: 8),
                      const Text("GitHub", style: TextStyle(color: Colors.black)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
