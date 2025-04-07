import 'package:flutter/material.dart';
import 'package:pomodoro/screens/assets_screens/custom_drawer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? logoUrl;

  @override
  void initState() {
    super.initState();
    _fetchLogo(); // Logo'yu çekiyoruz
  }

  // Logo URL'sini çekmek için API isteği
  Future<void> _fetchLogo() async {
    setState(() {
      logoUrl = 'https://res.cloudinary.com/dcho616lp/image/upload/v1744061032/logo-MinkTick.png';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Center(child: Text("Home", style: TextStyle(fontSize: 28, fontWeight: FontWeight.w200, color: Colors.white))),
        backgroundColor: Color(0xFFC31F48),
      ),
      // CustomDrawer'ı kullanıyoruz
      drawer: CustomDrawer(logoUrl: logoUrl),
      body: Center(child: Text("Home Page Content")),
    );
  }
}
