import 'package:flutter/material.dart';

class ContextScreen extends StatelessWidget {
  final String contextId;

  const ContextScreen({required this.contextId, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Context: $contextId'),
      ),
      body: Center(
        child: Text(
          'Placeholder for Context Screen\nContext ID: $contextId',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
