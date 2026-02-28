import 'package:flutter/material.dart';

import 'src/ui/menu_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MenuScreen(), // ensures Directionality, Theme, MediaQuery, etc.
      debugShowCheckedModeBanner: false,
    );
  }
}