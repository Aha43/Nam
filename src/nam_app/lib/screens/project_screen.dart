import 'package:flutter/material.dart';

class ProjectScreen extends StatelessWidget {
  final String? projectId;

  const ProjectScreen({required this.projectId, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Project: $projectId'),
      ),
      body: Center(
        child: Text('Placeholder for Project Screen\nProject ID: $projectId'),
      ),
    );
  }
}
