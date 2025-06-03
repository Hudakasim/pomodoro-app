import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'firebase_options.dart';
import 'screens/settings.dart';
import 'screens/home_page/home.dart';
import 'screens/sign_in_page/login.dart';
import 'screens/sign_in_page/register.dart';
import 'screens/profil_page/profil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Supabase.initialize(
    url: 'https://nkubvldqzpppwfccjxte.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5rdWJ2bGRxenBwcHdmY2NqeHRlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDg3OTY1MDcsImV4cCI6MjA2NDM3MjUwN30.R6YmnPljILWJIldWJWlIEzIzwhXG7KH1GfssrS0lU4c',
  );
  runApp(const Pomodoro());
}


class Pomodoro extends StatelessWidget {
    const Pomodoro({super.key});

    @override
    Widget build(BuildContext context) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
            title: 'Pomodoro App',
            theme: ThemeData(
                primarySwatch: Colors.blue,
            ),
            initialRoute: '/',
            routes: {
                '/': (context) => const Login(),
                '/register': (context) => RegisterPage(),
                '/home': (context) => const Home(focusDuration: 25, restDuration: 5),
                '/settings': (context) => const Settings(),
                '/profile': (context) => const Profile(),
            },
        );
    }
}
