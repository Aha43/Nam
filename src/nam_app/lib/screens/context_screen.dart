import 'package:flutter/material.dart';
import 'package:nam_app/core/abstractions/services/action_service.dart';
import 'package:nam_app/core/entities/action.dart';
import 'package:nam_app/core/entities/context.dart';

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
              return ListTile(
                title: Text(action.title),
                subtitle: Text(action.description ?? ''),
                trailing: action.projectId != null
                    ? Text('Project: ${action.projectId}')
                    : null,
                onTap: () {
                  // Open the edit action dialog (placeholder for now)
                  print('Edit action: ${action.title}');
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
    return allActions;
    // return allActions.where((action) {
    //   return contextEntity.ruleFunction(action, contextEntity.tags);
    // }).toList();
  }
}
