import 'package:flutter/material.dart';
import 'dart:async';

class Rest extends StatefulWidget {
  const Rest({super.key});

  @override
  State<Rest> createState() => _RestState();
}

class _RestState extends State<Rest> {
  int restTime = 5; // Default rest time
  int secondsLeft = 5 * 60; // Rest time in seconds
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
              'Rest Time: ${formatTime(secondsLeft)}',
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
