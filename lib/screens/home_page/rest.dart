import 'package:flutter/material.dart';
import 'dart:async';

class Rest extends StatefulWidget {
  final int restTime;
  const Rest({super.key, required this.restTime});
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
    secondsLeft = widget.restTime * 60;
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
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: 200,
                      width: 200,
                      child: CircularProgressIndicator(
                        value: 1 - (secondsLeft / (widget.restTime * 60)),
                        strokeWidth: 12,
                        backgroundColor: Colors.pink.shade100,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.grey.shade400),
                      ),
                    ),
                    Text(
                      formatTime(secondsLeft),
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        isTimerRunning ? Icons.pause : Icons.play_arrow,
                        size: 32,
                      ),
                      onPressed: () {
                        if (isTimerRunning) {
                          stopTimer();
                        } else {
                          startTimer();
                        }
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.stop, size: 32),
                      onPressed: () {
                        _timer.cancel();
                        setState(() {
                          isTimerRunning = false;
                          secondsLeft = widget.restTime * 60;
                        });
                      },
                    ),
                  ],
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
