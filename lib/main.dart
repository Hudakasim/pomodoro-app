import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/settings.dart';
import 'screens/home_page/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Pomodoro());
}


class Pomodoro extends StatelessWidget {
    const Pomodoro({super.key});

    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            title: 'Drawer Demo',
            theme: ThemeData(
                primarySwatch: Colors.blue,
            ),
            initialRoute: '/',
            routes: {
                '/': (context) => const Home(focusDuration: 25, restDuration: 5),
                '/settings': (context) => const Settings(),
            },
        );
    }
}
