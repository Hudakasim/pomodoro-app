import 'package:flutter/material.dart';

class PomodoroProvider with ChangeNotifier {
  int _focusTime = 25; // Default focus time
  int _restTime = 5;   // Default rest time

  int get focusTime => _focusTime;
  int get restTime => _restTime;

  // Focus time'ı güncelleme fonksiyonu
  void setFocusTime(int time) {
    _focusTime = time;
    notifyListeners();
  }

  // Rest time'ı güncelleme fonksiyonu
  void setRestTime(int time) {
    _restTime = time;
    notifyListeners();
  }
}
