import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:nam_app/core/abstractions/repositories/repositories.dart';
import 'package:nam_app/core/abstractions/services/inbox_service.dart';
import 'package:nam_app/infrastructure/repositories/in_memory/in_memory_action_repository.dart';
import 'package:nam_app/infrastructure/repositories/in_memory/in_memory_inbox_item_repository.dart';
import 'package:nam_app/infrastructure/repositories/in_memory/in_memory_project_repository.dart';
import 'package:nam_app/services/inbox_service_impl.dart';
import 'package:nam_app/widgets/persistent_scaffold.dart';
import 'screens/inbox_screen.dart';

void main() {
  final getIt = GetIt.instance;

  // Register repositories
  getIt.registerSingleton<InboxItemRepository>(InMemoryInboxItemRepository());
  getIt.registerSingleton<ActionRepository>(InMemoryActionRepository());
  getIt.registerSingleton<ProjectRepository>(InMemoryProjectRepository());

  // Register service
  getIt.registerSingleton<InboxService>(
    InboxServiceImpl(
      getIt<InboxItemRepository>(),
      getIt<ActionRepository>(),
      getIt<ProjectRepository>(),
    ),
  );

  runApp(const NamApp());
}

class NamApp extends StatelessWidget {
  const NamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: PersistentScaffold(
        initialScreen: InboxScreen(), // Start with InboxScreen
      ),
    );
  }
}
