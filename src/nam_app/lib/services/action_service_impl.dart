import 'package:nam_app/core/abstractions/services/action_service.dart';
import 'package:nam_app/core/entities/action.dart';

class InMemoryActionService implements ActionService {
  final List<NamAction> _actions = [
    NamAction(id: '1', title: 'Action 1', tags: ['work']),
    NamAction(id: '2', title: 'Action 2', tags: ['home']),
    NamAction(id: '3', title: 'Action 3', tags: ['errand']),
    NamAction(id: '4', title: 'Action 4', tags: ['work', 'urgent']),
  ];

  @override
  Future<List<NamAction>> getAllActions() async {
    return _actions;
  }

  @override
  Future<void> addAction(NamAction action) async {
    _actions.add(action);
  }

  @override
  Future<void> deleteAction(String id) async {
    _actions.removeWhere((action) => action.id == id);
  }

  @override
  Future<void> updateAction(NamAction action) async {
    final index = _actions.indexWhere((a) => a.id == action.id);
    if (index != -1) {
      _actions[index] = action;
    }
  }
}
