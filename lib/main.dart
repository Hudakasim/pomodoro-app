import 'package:cloudinary_url_gen/cloudinary.dart';
import 'package:flutter/material.dart';
import 'package:pomodoro/screens/home.dart';
import 'package:pomodoro/screens/login.dart';
import 'package:pomodoro/screens/settings.dart';

var cloudinary = Cloudinary.fromStringUrl('cloudinary://API_KEY:API_SECRET@CLOUD_NAME');

void main() {
  runApp(Pomodoro());
}

class Pomodoro extends StatelessWidget {
  const Pomodoro({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Login(),  // İlk açılışta Login sayfası görünecek
        routes: {
          '/login': (context) => Login(),
          '/home': (context) => Home(),
          '/settings': (context) => Settings(),
        },
    );
  }
}
