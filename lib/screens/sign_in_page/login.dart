import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'register.dart';
import 'package:google_sign_in/google_sign_in.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // // Kullanıcıyı giriş yaptıktan sonra bilgileri SharedPreferences'e kaydetme
  // Future<void> _saveLoginData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('username', _usernameController.text);
  //   await prefs.setString('password', _passwordController.text);
  // }

  // // SharedPreferences'den veriyi okuma
  // Future<void> _loadLoginData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? username = prefs.getString('username');
  //   String? password = prefs.getString('password');
  //   if (username != null && password != null) {
  //     print("Saved Username: $username");
  //     print("Saved Password: $password");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Login",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w200, color: Colors.white),
          ),
        ),
        backgroundColor: Color(0xFFC31F48),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(50, 0, 50, 150),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo/logo.png',
              height: 100,
            ),
            Text("Welcome to MindTick!", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 50),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: "User Name",
                labelStyle: TextStyle(color: Colors.pink),
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 2.0),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                hintText: "Enter Your User Name",
                hintStyle: TextStyle(fontSize: 13),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: "Password",
                labelStyle: TextStyle(color: Colors.pink),
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 2.0),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                hintText: "Enter Your Password",
                hintStyle: TextStyle(fontSize: 13),
              ),
              obscureText: true,
            ),
            SizedBox(height: 50),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFC31F48),
                side: BorderSide(width: 1, color: Colors.grey),
                padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
              ),
            onPressed: () async {
              try {
                // Firebase ile giriş yap
                await FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: _usernameController.text.trim(),
                  password: _passwordController.text.trim(),
                );
                // Başarılı giriş → yönlendir
                Navigator.pushNamed(context, '/home');
              } catch (e) {
                // Hata olursa kullanıcıya göster
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Giriş Hatası: ${e.toString()}")),
                );
              }
            },
              child: Text(
                "Login",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage()),
                );
              },
              child: Text("Hesabın yok mu? Kayıt ol"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                side: BorderSide(color: Colors.grey),
                padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
              ),
              onPressed: () => _signInWithGoogle(context),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Image.asset('lib/assets/images/google.png', height: 24), // ikon dosyan varsa
                  SizedBox(width: 10),
                  Text("Google ile Giriş", style: TextStyle(color: Colors.black)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
Future<void> _signInWithGoogle(BuildContext context) async {
  try {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) return; // kullanıcı iptal etti

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
    Navigator.pushNamed(context, '/home');
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Google ile giriş başarısız: $e")),
    );
  }
}

