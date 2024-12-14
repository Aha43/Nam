import 'package:flutter/material.dart';
import 'screens/inbox_screen.dart';

void main() {
  runApp(const NamApp());
}

class NamApp extends StatelessWidget {
  const NamApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nam - Next Action Master',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const InboxScreen(),
    );
  }
}
