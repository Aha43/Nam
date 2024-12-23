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
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addAction(context),
        tooltip: 'Add Action', // Call the _addAction method
        child: const Icon(Icons.add),
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

  Future<void> _addAction(BuildContext context) async {
    final newAction = NamAction(
      id: DateTime.now().toIso8601String(), // Generate a unique ID
      title: '',
      description: '',
      tags: widget.contextEntity.tags.toList(), // Pre-apply the context's tags
    );

    showDialog(
      context: context,
      builder: (context) {
        return ActionDialog(
          action: newAction,
          getProjects: () async {
            // Fetch project options for the dropdown
            return [
              {'id': '1', 'name': 'Project 1'},
              {'id': '2', 'name': 'Project 2'},
            ];
          },
          onSave: (updatedAction) async {
            if (widget.contextEntity.tags
                .any((tag) => !updatedAction.tags.contains(tag))) {
              await _showTagWarningDialog(
                  context); // Show warning if tags are modified
            }
            await widget.actionService.addAction(updatedAction); // Save action
            _refreshActions(); // Refresh the list
          },
          onCancel: (_) {
            // Handle cancel (optional, no changes needed)
            return Future.value();
          },
        );
      },
    );
  }

  Future<void> _showTagWarningDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Tag Warning'),
          content: const Text(
            'The tags have been modified, so this action may no longer appear in the current context.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
