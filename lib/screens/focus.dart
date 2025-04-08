import 'package:flutter/material.dart';
import 'dart:async';

class Focus_Study extends StatefulWidget {
  const Focus_Study({super.key});

  @override
  State<Focus_Study> createState() => _Focus_StudyState();
}

class _Focus_StudyState extends State<Focus_Study> {
  int focusTime = 25; // Default focus time
  int secondsLeft = 25 * 60; // Focus time in seconds
  bool isTimerRunning = false;
  late Timer _timer;

  void startTimer() {
    setState(() {
      isTimerRunning = true;
    });

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (secondsLeft > 0) {
        setState(() {
          secondsLeft--;
        });
      } else {
        _timer.cancel();
        setState(() {
          isTimerRunning = false;
        });
      }
    });
  }

  void stopTimer() {
    setState(() {
      _timer.cancel();
      isTimerRunning = false;
    });
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Focus Time: ${formatTime(secondsLeft)}',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: isTimerRunning ? stopTimer : startTimer,
              child: Text(isTimerRunning ? 'Stop' : 'Start'),
            ),
          ],
        ),
      ),
    );
  }
}
