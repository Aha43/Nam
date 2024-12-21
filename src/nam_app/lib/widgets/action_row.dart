import 'package:flutter/material.dart';
import 'package:nam_app/core/entities/action.dart';

class ActionRow extends StatelessWidget {
  final NamAction action;
  final String? projectName; // Optional project name
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onNavigateToProject;

  const ActionRow({
    required this.action,
    this.projectName,
    required this.onEdit,
    required this.onDelete,
    required this.onNavigateToProject,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: ListTile(
        title: Text(action.title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (action.description != null && action.description!.isNotEmpty)
              Text(action.description!),
            if (projectName != null)
              Text('Project: $projectName', style: const TextStyle(color: Colors.grey)),
          ],
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            switch (value) {
              case 'edit':
                onEdit();
                break;
              case 'delete':
                onDelete();
                break;
              case 'navigate':
                onNavigateToProject();
                break;
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(value: 'edit', child: Text('Edit')),
            const PopupMenuItem(value: 'delete', child: Text('Delete')),
            const PopupMenuItem(value: 'navigate', child: Text('Go to Project')),
          ],
        ),
      ),
    );
  }
}
