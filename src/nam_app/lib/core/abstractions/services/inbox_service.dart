// lib/core/abstractions/services/inbox_service.dart

import 'package:nam_app/core/entities/action.dart';
import 'package:nam_app/core/entities/inbox_item.dart';

abstract class InboxService {
  Future<List<InboxItem>> getInboxItems();
  Future<void> addInboxItem(String content);
  Future<void> deleteInboxItem(String id);
  Future<NamAction> convertToAction(InboxItem item);
  Future<void> markAsDone(InboxItem item);
}
