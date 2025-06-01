import 'package:flutter/material.dart';
import '../../widgets/base.dart';
import 'rest.dart';
import 'focus.dart';

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
  
  @override
  void initState() {
    super.initState();
    focusTime = widget.focusDuration;
    restTime = widget.restDuration;

    _pages = [
      Focus_Study(focusTime: focusTime),
      Rest(restTime: restTime),
    ];
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
