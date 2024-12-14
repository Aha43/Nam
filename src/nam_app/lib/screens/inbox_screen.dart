// lib/screens/inbox_screen.dart

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:nam_app/core/entities/inbox_item.dart';
import 'package:nam_app/core/abstractions/services/inbox_service.dart';

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
    _loadInboxItems();
  }

  Future<void> _deleteInboxItem(String id) async {
    await _service.deleteInboxItem(id);
    _loadInboxItems();
  }

  Future<void> _convertToAction(InboxItem item) async {
    await _service.convertToAction(item);
    _loadInboxItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inbox'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Quick Add to Inbox',
              ),
              onSubmitted: (value) => _addInboxItem(value),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, index) {
                final item = _items[index];
                return Dismissible(
                  key: Key(item.id),
                  onDismissed: (direction) {
                    if (direction == DismissDirection.startToEnd) {
                      _deleteInboxItem(item.id);
                    } else if (direction == DismissDirection.endToStart) {
                      _convertToAction(item);
                    }
                  },
                  background: Container(
                    color: Colors.red,
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  secondaryBackground: Container(
                    color: Colors.green,
                    child: const Icon(Icons.check, color: Colors.white),
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
}
