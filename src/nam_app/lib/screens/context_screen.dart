import 'package:flutter/material.dart';
import 'package:nam_app/core/abstractions/services/action_service.dart';
import 'package:nam_app/core/entities/action.dart';
import 'package:nam_app/core/entities/context.dart';
import 'package:nam_app/widgets/action_dialog.dart';
import 'package:nam_app/widgets/action_row.dart';

class ContextScreen extends StatefulWidget {
  final Context contextEntity;
  final ActionService actionService;

  const ContextScreen({
    required this.contextEntity,
    required this.actionService,
    super.key,
  });

  @override
  ContextScreenState createState() => ContextScreenState();
}

class ContextScreenState extends State<ContextScreen> {
  List<NamAction> _actions = [];

  @override
  void initState() {
    super.initState();
    _refreshActions(); // Initial load
  }

  Future<void> _refreshActions() async {
    final allActions = await widget.actionService.getAllActions();
    final filteredActions = allActions.where((action) {
      return widget.contextEntity
          .ruleFunction(action, widget.contextEntity.tags);
    }).toList();

    setState(() {
      _actions = filteredActions;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Context: ${widget.contextEntity.name}'),
      ),
      body: _actions.isEmpty
          ? const Center(child: Text('No actions found for this context.'))
          : ListView.builder(
              itemCount: _actions.length,
              itemBuilder: (context, index) {
                final action = _actions[index];
                return ActionRow(
                  action: action,
                  projectName: null, // Replace with project name logic
                  onEdit: () async {
                    _editAction(context, action);
                  },
                  onDelete: () async {
                    final shouldDelete = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Delete Action'),
                        content: Text(
                            'Are you sure you want to delete "${action.title}"?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, true),
                            child: const Text('Delete'),
                          ),
                        ],
                      ),
                    );
                    if (shouldDelete == true) {
                      await widget.actionService.deleteAction(action.id);
                      _refreshActions();
                    }
                  },
                  onNavigateToProject: () {
                    // Placeholder navigation
                    print('Navigate to project: ${action.projectId}');
                  },
                );
              },
            ),
    );
  }

  Future<void> _editAction(BuildContext context, NamAction action) async {
    showDialog(
      context: context,
      builder: (context) {
        return ActionDialog(
          action: action,
          getProjects: () async {
            return [
              {'id': '1', 'name': 'Project 1'},
              {'id': '2', 'name': 'Project 2'},
            ];
          },
          onSave: (updatedAction) async {
            // Handle the save directly
            await widget.actionService.updateAction(updatedAction);
            _refreshActions();
          },
          onCancel: (_) {
            // Handle cancel (optional, if necessary)
            _refreshActions();
            return Future.value();
          },
        );
      },
    );
  }
}
