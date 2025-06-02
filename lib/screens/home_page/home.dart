import 'package:flutter/material.dart';
import '../../widgets/base.dart';
import 'rest.dart';
import 'focus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/local_storage_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatefulWidget {
  final int focusDuration;
  final int restDuration;

  const Home({super.key, required this.focusDuration, required this.restDuration});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final int focusTime;
  late final int restTime;
  int _selectedIndex = 0;

  late final List<Widget> _pages;

  bool _showWelcome = false;
  String? _userName;

  @override
  void initState() {
    super.initState();
    focusTime = widget.focusDuration;
    restTime = widget.restDuration;
    _pages = [
      Focus_Study(focusTime: focusTime),
      Rest(restTime: restTime),
    ];
    _checkWelcome();
  }

  Future<void> _checkWelcome() async {
    final prefs = await SharedPreferences.getInstance();
    bool? shown = prefs.getBool('welcome_shown');

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    final userId = user.uid;

    if (shown == null || shown == false) {
      final storage = LocalStorageService();
      final userData = await storage.getUserData(userId);

      setState(() {
        _showWelcome = true;
        _userName = userData['name'] ?? 'Kullanıcı';
      });

      await prefs.setBool('welcome_shown', true);
    }
  }

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Tick Tack',
      content: Column(
        children: [
          if (_showWelcome)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Hoşgeldin, $_userName!',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          Expanded(
            child: _pages[_selectedIndex],
          ),
          BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _navigateBottomBar,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.timer),
                label: 'Focus',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.night_shelter_sharp),
                label: 'Rest',
              ),
            ],
            selectedItemColor: const Color(0xFFC31F48),
            unselectedItemColor: Colors.grey,
          ),
        ],
      ),
    );
  }
}
