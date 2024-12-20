import 'package:flutter/material.dart';
import 'package:nam_app/core/abstractions/services/context_service.dart';
import 'package:nam_app/core/entities/context.dart';
import 'package:nam_app/screens/inbox_screen.dart';

class MainMenu extends StatelessWidget {
  final ContextService contextService;
  final void Function(Widget) onNavigate; // Navigation callback

  const MainMenu({
    required this.contextService,
    required this.onNavigate,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: FutureBuilder<List<Context>>(
        future: contextService.getContexts(),
        builder: (context, snapshot) {
          final contexts = snapshot.data ?? [];

          return ListView(
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                child: Text('Next Action Master'),
              ),
              // Static Navigation Items
              ListTile(
                title: const Text('Inbox'),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  onNavigate(const InboxScreen()); // Navigate to InboxScreen
                },
              ),
              // Dynamic Context Items
              ...contexts.map((contextItem) {
                return ListTile(
                  title: Text(contextItem.name),
                  onTap: () {
                    Navigator.pop(context); // Close the drawer
                    onNavigate(const InboxScreen());
                    //onNavigate(ContextScreen(contextId: contextItem.id));
                  },
                );
              }),
              // Placeholder for future screens
              ListTile(
                title: const Text('Settings'),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  // Navigate to settings placeholder
                  onNavigate(const Center(child: Text('Settings Placeholder')));
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
