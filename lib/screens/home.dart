import 'package:flutter/material.dart';
import 'package:pomodoro/screens/rest.dart';
import 'package:pomodoro/screens/focus.dart';
import 'package:pomodoro/screens/assets_screens/custom_drawer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List _pages = [
    Focus_Study(),
    Rest(),
  ];

  int _selectedIndex = 0;

  // Bottom Navigation Bar tıklama işlevi
  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  String? logoUrl;
  int focusTime = 25;
  int restTime = 5;

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
        title: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 50, 0),
            child: Text("Home", style: TextStyle(fontSize: 28, fontWeight: FontWeight.w200, color: Colors.white)),
          ),
        ),
        backgroundColor: Color(0xFFC31F48),
      ),
      drawer: CustomDrawer(logoUrl: logoUrl),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _navigateBottomBar,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.timer),
            label: 'Focus',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.night_shelter_sharp),
            label: 'Rest',
          ),
        ],
        selectedItemColor: Color(0xFFC31F48),
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
