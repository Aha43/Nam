import 'package:flutter/material.dart';
import 'package:nam_app/core/entities/action.dart' as nam;

class ActionDialog extends StatefulWidget {
  final nam.Action action;
  final Future<List<Map<String, String>>> Function() getProjects; // Fetch project list
  final void Function(nam.Action updatedAction) onSave;

  const ActionDialog({
    required this.action,
    required this.getProjects,
    required this.onSave,
    super.key,
  });

  @override
  ActionDialogState createState() => ActionDialogState();
}

class ActionDialogState extends State<ActionDialog> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  String? _selectedProjectId;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.action.title);
    _descriptionController = TextEditingController(text: widget.action.description);
    _selectedProjectId = widget.action.projectId;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Action'),
      content: FutureBuilder<List<Map<String, String>>>(
        future: widget.getProjects(),
        builder: (context, snapshot) {
          final projectOptions = snapshot.data ?? [];

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Read-Only Creation Date
                Text(
                  'Created At: ${widget.action.createdAt.toLocal()}',
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 16),
                // Action Name
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                const SizedBox(height: 16),
                // Action Description
                TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
                // Project Selection
                DropdownButtonFormField<String?>(
                  value: _selectedProjectId,
                  items: [
                    const DropdownMenuItem(
                      value: null,
                      child: Text('No Project'),
                    ),
                    ...projectOptions.map((project) {
                      return DropdownMenuItem(
                        value: project['id'],
                        child: Text(project['name'] ?? ''),
                      );
                    }),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedProjectId = value;
                    });
                  },
                  decoration: const InputDecoration(labelText: 'Project'),
                ),
                const SizedBox(height: 16),
                // Tags (Placeholder for tag management)
                Wrap(
                  children: [
                    const Chip(label: Text('Tag 1')),
                    const Chip(label: Text('Tag 2')),
                    ActionChip(
                      label: const Text('+ Add Tag'),
                      onPressed: () {
                        // Future implementation for tag management
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context), // Cancel without saving
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            // Update the action with new values
            widget.action.title = _nameController.text;
            widget.action.description = _descriptionController.text;
            widget.action.projectId = _selectedProjectId;
            // Trigger the save callback
            widget.onSave(widget.action);
            Navigator.pop(context);
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
