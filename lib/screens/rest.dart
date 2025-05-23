import 'package:flutter/material.dart';
import 'dart:async';
import 'global.dart';  // Global değişkenleri import ediyoruz

class Rest extends StatefulWidget {
  const Rest({super.key});  // Parametre almayacağız, global değişkeni kullanacağız

  @override
  State<Rest> createState() => _RestState();
}

class _RestState extends State<Rest> {
  late int secondsLeft;  // Kalan süreyi tutacak değişken
  bool isTimerRunning = false;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    secondsLeft = restTime * 60;  // Global restTime'ı doğrudan kullanıyoruz ve saniyeye çeviriyoruz
  }

  void startTimer() {
    setState(() {
      isTimerRunning = true;  // Timer başlatıldı
    });

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (secondsLeft > 0) {
        if (mounted){
          setState(() {
            secondsLeft--;  // Zamanı bir saniye azaltıyoruz
          });
        }
      } else {
        _timer.cancel();  // Timer bitince durduruluyor
        setState(() {
          isTimerRunning = false;
        });
      }
    });
  }

  void stopTimer() {
    setState(() {
      _timer.cancel();  // Timer durduruluyor
      isTimerRunning = false;  // Timer durdu
    });
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;  // Dakika
    int remainingSeconds = seconds % 60;  // Kalan saniye
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';  // Format: MM:SS
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Kalan dinlenme zamanını gösteriyoruz
            Text(
              'Rest Time:\n ${formatTime(secondsLeft)}',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: isTimerRunning ? stopTimer : startTimer,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFC31F48),
                side: BorderSide(width: 1, color: Colors.grey),
                padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
              ),
              child: Text(
                isTimerRunning ? 'Stop' : 'Start',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
