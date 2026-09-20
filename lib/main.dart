import 'package:flutter/material.dart';
import 'ui/menu_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'F1 Vault UAS',
      theme: ThemeData.dark(),
      home: const MenuUI(),
    );
  }
}