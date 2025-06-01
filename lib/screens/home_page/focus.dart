import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class Focus_Study extends StatefulWidget {
  final int focusTime;
  const Focus_Study({super.key, required this.focusTime});

  @override
  State<Focus_Study> createState() => _Focus_StudyState();
}

class _Focus_StudyState extends State<Focus_Study> {
  late int secondsLeft;
  bool isTimerRunning = false;
  late Timer _timer;

  List<Map<String, Object>> tasks = [];
  final TextEditingController _taskController = TextEditingController();

  @override
  void initState() {
    super.initState();
    secondsLeft = widget.focusTime * 60;
    loadTasks();
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

  void addTask(String task) async {
    if (task.trim().isEmpty) return;

    setState(() {
      tasks.add({
        "task": task.trim(),
        "done": false,
      });
    });

    _taskController.clear();
    await saveTasks();
  }

  void removeTask(int index) async {
    setState(() => tasks.removeAt(index));
    await saveTasks();
  }

  void toggleTaskStatus(int index, bool? value) async {
    setState(() {
      tasks[index]['done'] = value ?? false;
    });
    await saveTasks();
  }

  Future<void> saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = tasks.map((e) => '${e['task']}|${e['done']}').toList();
    await prefs.setStringList('focus_tasks', encoded);
  }

  void loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getStringList('focus_tasks') ?? [];
    setState(() {
      tasks = stored.map((e) {
        final parts = e.split('|');
        return {
          "task": parts[0],
          "done": parts.length > 1 && parts[1] == 'true',
        };
      }).toList();
    });
  }

  String formatTime(int seconds) {
    return '${seconds ~/ 60}:${(seconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer.cancel();
    _taskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/background/focus.png',
            fit: BoxFit.cover,
          ),
        ),
        Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 10),
                // TIMER
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: 200,
                      width: 200,
                      child: CircularProgressIndicator(
                        value: 1 - (secondsLeft / (widget.focusTime * 60)),
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
                const SizedBox(height: 20),
                // TIMER BUTTONS
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
                          secondsLeft = widget.focusTime * 60;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // TASK INPUT
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: TextField(
                    controller: _taskController,
                    decoration: InputDecoration(
                      labelText: "Add a task",
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 20
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () => addTask(_taskController.text),
                      ),
                      suffixIconColor: Colors.black, // ➤ artı buton rengi
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black), // ➤ istediğin renk
                      ),
                    ),
                  ),

                ),
                const SizedBox(height: 10),
                // TASK LIST
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: tasks
                        .asMap()
                        .entries
                        .map(
                          (entry) => Row(
                            children: [
                              // Checkbox (left)
                              Checkbox(
                                value: entry.value['done'] as bool,
                                onChanged: (value) => toggleTaskStatus(entry.key, value),
                                activeColor: Color(0xFFC31F48),
                              ),
                              // Task text
                              Expanded(
                                child: Text(
                                  entry.value['task'] as String,
                                  style: TextStyle(
                                    fontSize: 16,
                                    decoration: (entry.value['done'] as bool)
                                        ? TextDecoration.lineThrough
                                        : null,
                                  ),
                                ),
                              ),
                              // Delete icon (right)
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () => removeTask(entry.key),
                              ),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
