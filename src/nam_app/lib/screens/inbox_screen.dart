// lib/screens/inbox_screen.dart

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:nam_app/core/entities/inbox_item.dart';
import 'package:nam_app/core/abstractions/services/inbox_service.dart';
import 'package:nam_app/widgets/action_dialog.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({super.key});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  final InboxService _service = GetIt.instance<InboxService>();
  final TextEditingController _controller = TextEditingController();
  List<InboxItem> _items = [];

  @override
  void initState() {
    super.initState();
    _loadInboxItems();
  }

  Future<void> _loadInboxItems() async {
    final items = await _service.getInboxItems();
    setState(() {
      _items = items;
    });
  }

  Future<void> _addInboxItem(String content) async {
    if (content.isEmpty) return;

    await _service.addInboxItem(content);
    _controller.clear();

    if (!mounted) return; // Ensure the widget is still mounted
    
    _loadInboxItems(); // Ensure the list is reloaded after adding an item

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Inbox item added!')),
    );
  }

  Future<void> _deleteInboxItem(String id) async {
    await _service.deleteInboxItem(id);
    _loadInboxItems();
  }

  Future<void> _convertToAction(InboxItem item) async {
    final action = await _service.convertToAction(item);

    if (!mounted) return; // Ensure the widget is still mounted

    _loadInboxItems();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Inbox item "${item.content}" converted to Action!')),
    );

    _editAction(context, action);
  }

  Future<void> _convertToProject(InboxItem item) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Inbox item "${item.content}" converted to Project!')),
    );
  }

  Future<void> _showSwipeMenu(InboxItem item) async {
  final action = await showModalBottomSheet<String>(
    context: context,
    builder: (context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Label to show item content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              item.content,
              style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.check_circle),
            title: const Text('Done'),
            onTap: () => Navigator.pop(context, 'done'),
          ),
          ListTile(
            leading: const Icon(Icons.add_task),
            title: const Text('To Action'),
            onTap: () => Navigator.pop(context, 'to_action'),
          ),
          ListTile(
            leading: const Icon(Icons.assignment),
            title: const Text('To Project'),
            onTap: () => Navigator.pop(context, 'to_project'),
          ),
          ListTile(
            leading: const Icon(Icons.cancel),
            title: const Text('Cancel'),
            onTap: () => Navigator.pop(context, 'cancel'),
          ),
        ],
      );
    },
  );

  switch (action) {
    case 'done':
      await _deleteInboxItem(item.id);
      break;
    case 'to_action':
      await _convertToAction(item);
      break;
    case 'to_project':
      await _convertToProject(item);
      break;
    case 'cancel':
    default:
      break;
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inbox'),
      ),
      body: Column(
        children: [
          // Input Field for Adding Items
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Add to Inbox',
                suffixIcon: Icon(Icons.add),
              ),
              onSubmitted: (value) => _addInboxItem(value),
            ),
          ),

          // List of Inbox Items
          Expanded(
            child: ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, index) {
                final item = _items[index];
                return Dismissible(
                  key: Key(item.id),
                  confirmDismiss: (direction) async {
                    if (direction == DismissDirection.startToEnd) {
                      await _deleteInboxItem(item.id);
                      return true;
                    } else if (direction == DismissDirection.endToStart) {
                      await _showSwipeMenu(item);
                      return false; // Prevent auto-dismiss after swipe
                    }
                    return false;
                  },
                  background: Container(
                    color: Colors.red,
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  secondaryBackground: Container(
                    color: Colors.green,
                    child: const Icon(Icons.menu, color: Colors.white),
                  ),
                  child: ListTile(
                    title: Text(item.content),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _editAction(BuildContext context, dynamic action) {
    showDialog(
      context: context,
      builder: (context) {
        return ActionDialog(
          action: action,
          getProjects: () async {
            // Replace with a call to your ProjectRepository to fetch projects
            return [
              {'id': '1', 'name': 'Project 1'},
              {'id': '2', 'name': 'Project 2'},
            ];
          },
          onSave: (updatedAction) {
            // Save the updated action to your repository or service
            print('Action saved: ${updatedAction.title}, Project: ${updatedAction.projectId}');
          },
          onCancel: (cancelledAction) async {
            // Save the updated action to your repository or service
            print('Action editing cancelled: ${cancelledAction?.title}');
            if (cancelledAction != null) {
              await _service.addInboxItem(cancelledAction.title);
              _loadInboxItems();
            }
          }
        );
      },
    );
  }

}
