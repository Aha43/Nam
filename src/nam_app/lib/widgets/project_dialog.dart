import 'package:flutter/material.dart';
import 'package:nam_app/core/entities/project.dart';

class ProjectDialog extends StatefulWidget {
  final Project project;
  final Future<List<Map<String, String>>> Function() getProjects;
  final void Function(Project updatedProject) onSave;
  final Future<void> Function(Project? project)? onCancel;

  const ProjectDialog({
    required this.project,
    required this.getProjects,
    required this.onSave,
    this.onCancel,
    super.key,
  });

  @override
  ProjectDialogState createState() => ProjectDialogState();
}

class ProjectDialogState extends State<ProjectDialog> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  String? _selectedParentProjectId;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.project.title);
    _descriptionController = TextEditingController(text: widget.project.description);
    _selectedParentProjectId = widget.project.parentId;
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
      title: const Text('Edit Project'),
      content: FutureBuilder<List<Map<String, String>>>(
        future: widget.getProjects(),
        builder: (context, snapshot) {
          final projectOptions = snapshot.data ?? [];

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Project Name
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                const SizedBox(height: 16),
                // Project Description
                TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
                // Parent Project Selection
                DropdownButtonFormField<String?>(
                  value: _selectedParentProjectId,
                  items: [
                    const DropdownMenuItem(
                      value: null,
                      child: Text('No Parent'),
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
                      _selectedParentProjectId = value;
                    });
                  },
                  decoration: const InputDecoration(labelText: 'Parent Project'),
                ),
              ],
            ),
          );
        },
      ),
      actions: [
        // Cancel Button
        TextButton(
          onPressed: () async {
            if (widget.onCancel != null) {
              await widget.onCancel!(widget.project);
            }
            Navigator.pop(context); // Close the dialog without changes
          },
          child: const Text('Cancel'),
        ),
        // Save Button
        TextButton(
          onPressed: () {
            // Update the project with user input
            widget.project.title = _nameController.text;
            widget.project.description = _descriptionController.text;
            widget.project.parentId = _selectedParentProjectId;

            widget.onSave(widget.project); // Save the project
            Navigator.pop(context); // Close the dialog
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
