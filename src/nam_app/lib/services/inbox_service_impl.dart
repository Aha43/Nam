// lib/services/inbox_service_impl.dart

import 'package:nam_app/core/entities/action.dart';
import 'package:nam_app/core/entities/inbox_item.dart';
import 'package:nam_app/core/abstractions/repositories/repositories.dart';
import 'package:nam_app/core/abstractions/services/inbox_service.dart';
import 'package:nam_app/core/entities/project.dart';

class InboxServiceImpl implements InboxService {
  final InboxItemRepository _inboxRepository;
  final ActionRepository _actionRepository;
  final ProjectRepository _projectRepository;

  InboxServiceImpl(this._inboxRepository, this._actionRepository, this._projectRepository);

  @override
  Future<List<InboxItem>> getInboxItems() {
    return _inboxRepository.getAll();
  }

  @override
  Future<void> addInboxItem(String content) async {
    final newItem = InboxItem(
      id: DateTime.now().toIso8601String(),
      content: content,
    );
    await _inboxRepository.add(newItem);
  }

  @override
  Future<void> deleteInboxItem(String id) {
    return _inboxRepository.delete(id);
  }

  @override
  Future<NamAction> convertToAction(InboxItem item) async {
    final action = NamAction(
      id: item.id, // Reuse ID for traceability
      title: item.content // Map content to title
    );
    await _actionRepository.add(action);
    await _inboxRepository.delete(item.id);
    return action;
  }

  @override
  Future<Project> convertToProject(InboxItem item) async {
    final project = Project(
      id: item.id, // Reuse ID for traceability
      title: item.content // Map content to title
    );
    await _projectRepository.add(project);
    await _inboxRepository.delete(item.id);
    return project;
  }

  @override
  Future<void> markAsDone(InboxItem item) async {
    // Placeholder for more complex logic in the future
    await deleteInboxItem(item.id);
  }
}
