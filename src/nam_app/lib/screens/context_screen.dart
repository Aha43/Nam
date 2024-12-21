import 'package:flutter/material.dart';
import 'package:nam_app/core/abstractions/services/action_service.dart';
import 'package:nam_app/core/entities/action.dart';
import 'package:nam_app/core/entities/context.dart';
import 'package:nam_app/widgets/action_row.dart';

class ContextScreen extends StatelessWidget {
  final Context contextEntity;
  final ActionService actionService;

  const ContextScreen({
    required this.contextEntity,
    required this.actionService,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Context: ${contextEntity.name}'),
      ),
      body: FutureBuilder<List<NamAction>>(
        future: _getFilteredActions(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No actions found for this context.'));
          }

          final actions = snapshot.data!;
          return ListView.builder(
            itemCount: actions.length,
            itemBuilder: (context, index) {
              final action = actions[index];
              return ActionRow(
                action: action,
                projectName: _getProjectName(action.projectId), // Placeholder
                onEdit: () {
                  // Open the edit dialog
                  print('Edit action: ${action.title}');
                },
                onDelete: () {
                  // Delete the action
                  print('Delete action: ${action.title}');
                },
                onNavigateToProject: () {
                  // Navigate to project (placeholder)
                  print('Navigate to project: ${action.projectId}');
                },
              );
            },
          );
        },
      ),
    );
  }

  Future<List<NamAction>> _getFilteredActions() async {
    final allActions = await actionService.getAllActions();
    return allActions.where((action) {
      return contextEntity.ruleFunction(action, contextEntity.tags);
    }).toList();
  }

  String? _getProjectName(String? projectId) {
    // Placeholder: Replace with real project lookup logic
    return projectId == null ? null : 'Project $projectId';
  }
}
