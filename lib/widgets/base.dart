import 'package:flutter/material.dart';
import 'app_bar.dart';
import 'drawer.dart';

class BasePage extends StatelessWidget {
  final String title;
  final Widget content;  // Changed from String to Widget

  const BasePage({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: title),
      drawer: const DrawerMenu(),
      body: Center(child: content),
    );
  }
}
