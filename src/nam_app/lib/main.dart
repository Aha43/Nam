import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:nam_app/core/abstractions/repositories/repositories.dart';
import 'package:nam_app/core/abstractions/services/inbox_service.dart';
import 'package:nam_app/infrastructure/repositories/in_memory/in_memory_action_repository.dart';
import 'package:nam_app/infrastructure/repositories/in_memory/in_memory_inbox_item_repository.dart';
import 'package:nam_app/services/inbox_service_impl.dart';
import 'screens/inbox_screen.dart';

void main() {
  final getIt = GetIt.instance;

  // Register repositories
  getIt.registerSingleton<InboxItemRepository>(InMemoryInboxItemRepository());
  getIt.registerSingleton<ActionRepository>(InMemoryActionRepository());

  // Register service
  getIt.registerSingleton<InboxService>(
    InboxServiceImpl(
      getIt<InboxItemRepository>(),
      getIt<ActionRepository>(),
    ),
  );

  runApp(const NamApp());
}

class NamApp extends StatelessWidget {
  const NamApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nam - Next Action Master',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const InboxScreen(),
    );
  }
}
