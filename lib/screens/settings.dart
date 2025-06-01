import 'package:flutter/material.dart';
import 'package:pomodoro/screens/home_page/home.dart';
import 'package:pomodoro/widgets/base.dart';

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
    _focusTimeController.text = '25';
    _restTimeController.text = '5';
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
                setState(() {                });
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
                final focus = int.tryParse(_focusTimeController.text) ?? 25;
                final rest = int.tryParse(_restTimeController.text) ?? 5;

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Home(focusDuration: focus, restDuration: rest),
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
