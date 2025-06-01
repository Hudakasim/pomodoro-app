import 'package:flutter/material.dart';
import '../../widgets/base.dart';
import 'rest.dart';
import 'focus.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int focusTime = 25;
  int restTime = 5;
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    Focus_Study(),
    Rest(),
  ];

  @override
  void initState() {
    super.initState();
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
