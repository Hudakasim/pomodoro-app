import 'package:flutter/material.dart';
import 'screens/settings.dart';
import 'screens/home_page/home.dart';

void main() {
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
                '/': (context) => const Home(),
                '/settings': (context) => const Settings(),
            },
        );
    }
}

// class HomePage extends StatelessWidget {
//     const HomePage({super.key});

//     @override
//     Widget build(BuildContext context) {
//         return const BasePage(title: 'Ana Sayfa', content: 'Ana Sayfa');
//     }
// }

