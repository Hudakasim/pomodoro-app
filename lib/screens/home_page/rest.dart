import 'package:flutter/material.dart';
import 'dart:async';
import 'global.dart';

class Rest extends StatefulWidget {
  const Rest({super.key});

  @override
  State<Rest> createState() => _RestState();
}

class _RestState extends State<Rest> {
  late int secondsLeft;
  bool isTimerRunning = false;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    secondsLeft = restTime * 60;
  }

  void startTimer() {
    setState(() => isTimerRunning = true);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsLeft > 0 && mounted) {
        setState(() => secondsLeft--);
      } else {
        _timer.cancel();
        if (mounted) setState(() => isTimerRunning = false);
      }
    });
  }

  void stopTimer() {
    _timer.cancel();
    setState(() => isTimerRunning = false);
  }

  String formatTime(int seconds) {
    return '${seconds ~/ 60}:${(seconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background Image
        Positioned.fill(
          child: Image.asset(
            'assets/background/rest.png', // Different image for rest screen
            fit: BoxFit.cover,
          ),
        ),
        // Content Overlay
        Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Rest Time:\n${formatTime(secondsLeft)}',
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // White text for better visibility
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: isTimerRunning ? stopTimer : startTimer,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFC31F48),
                    side: const BorderSide(width: 1, color: Colors.grey),
                    padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                  ),
                  child: Text(
                    isTimerRunning ? 'Stop' : 'Start',
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
