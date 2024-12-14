import 'package:flutter/material.dart';

class InboxScreen extends StatelessWidget {
  const InboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inbox'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              title: const Text('Contexts'),
              onTap: () {
                Navigator.pushNamed(context, '/contexts');
              },
            ),
            ListTile(
              title: const Text('Tags'),
              onTap: () {
                Navigator.pushNamed(context, '/tags');
              },
            ),
            ListTile(
              title: const Text('Settings'),
              onTap: () {
                Navigator.pushNamed(context, '/settings');
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Quick Add to Inbox',
              ),
              onSubmitted: (value) {
                // TODO: Add logic to save to inbox
                print('Added: $value');
              },
            ),
          ),
          const Expanded(
            child: Center(
              child: Text('Inbox Items will be displayed here.'),
            ),
          ),
        ],
      ),
    );
  }
}
