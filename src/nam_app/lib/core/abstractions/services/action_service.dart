import 'package:nam_app/core/entities/action.dart';

abstract class ActionService {
  Future<List<NamAction>> getAllActions();
  Future<void> addAction(NamAction action);
  Future<void> deleteAction(String id);
  Future<void> updateAction(NamAction action);
}
