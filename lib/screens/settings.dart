import 'package:flutter/material.dart';
import 'package:pomodoro/screens/home.dart';
import 'package:pomodoro/widgets/base.dart';
import 'global.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final TextEditingController _focusTimeController = TextEditingController();
  final TextEditingController _restTimeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _focusTimeController.text = '$focusTime';
    _restTimeController.text = '$restTime';
  }


  @override
  void dispose() {
    _focusTimeController.dispose();
    _restTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Settings',
      content: Padding(
        padding: const EdgeInsets.fromLTRB(60, 40, 60, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Focus time setting
            Text(
              "Focus Time (minutes):",
              style: TextStyle(fontSize: 20),
            ),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  focusTime = int.tryParse(value) ?? 25;
                });
              },
              decoration: InputDecoration(
                hintText: 'Enter Focus Time',
                border: OutlineInputBorder(),
                labelText: 'Focus Time',
              ),
              controller: _focusTimeController,
            ),
            SizedBox(height: 20),

            // Rest time setting
            Text(
              "Rest Time (minutes):",
              style: TextStyle(fontSize: 20),
            ),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  restTime = int.tryParse(value) ?? 5;
                });
              },
              decoration: InputDecoration(
                hintText: 'Enter Rest Time',
                border: OutlineInputBorder(),
                labelText: 'Rest Time',
              ),
              controller: _restTimeController,
            ),
            SizedBox(height: 20),

            // Start button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFC31F48),
                side: BorderSide(width: 1, color: Colors.grey),
                padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Home(),
                  ),
                );
              },
              child: Text(
                "Start Focus Session",
                style: TextStyle(fontSize: 16, color: Colors.white)
              ),
            ),
          ],
        ),
      ),
    );
  }
}
