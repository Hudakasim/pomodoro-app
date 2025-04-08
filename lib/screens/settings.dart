import 'package:flutter/material.dart';
import 'package:pomodoro/screens/assets_screens/custom_drawer.dart';
import 'package:pomodoro/screens/home.dart';
import 'global.dart'; // Global değişkenleri import ediyoruz

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
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
        title: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 50, 0),
            child: Text(
              "Settings",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w200, color: Colors.white),
            ),
          ),
        ),
        backgroundColor: Color(0xFFC31F48),
      ),

      drawer: CustomDrawer(logoUrl: logoUrl),

      body: Padding(
        padding: const EdgeInsets.fromLTRB(60, 40, 60, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Focus time global değişkeni üzerinden erişim
            Text(
              "Focus Time (minutes):",
              style: TextStyle(fontSize: 20),
            ),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  // focusTime'ı global değişkene atıyoruz
                  focusTime = int.tryParse(value) ?? 25; // Default 25
                });
              },
              decoration: InputDecoration(
                hintText: 'Enter Focus Time',
                border: OutlineInputBorder(),
                labelText: 'Focus Time',
              ),
              controller: TextEditingController(text: '$focusTime'), // Default değer ile TextField'ı başlatıyoruz
            ),
            SizedBox(height: 20),
            // Rest time global değişkeni üzerinden erişim
            Text(
              "Rest Time (minutes):",
              style: TextStyle(fontSize: 20),
            ),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  // restTime'ı global değişkene atıyoruz
                  restTime = int.tryParse(value) ?? 5; // Default 5
                });
              },
              decoration: InputDecoration(
                hintText: 'Enter Rest Time',
                border: OutlineInputBorder(),
                labelText: 'Rest Time',
              ),
              controller: TextEditingController(text: '$restTime'), // Default değer ile TextField'ı başlatıyoruz
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFC31F48),
                side: BorderSide(width: 1, color: Colors.grey),
                padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
              ),
              onPressed: () {
                // Focus_Study ekranına gidiyoruz ve focusTime'ı iletiyoruz
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Home(),
                  ),
                );
              },
              child: Text("Start Focus Session", style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
