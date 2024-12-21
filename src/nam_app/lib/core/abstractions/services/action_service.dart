import 'package:nam_app/core/entities/action.dart';

abstract class ActionService {
  Future<List<NamAction>> getAllActions();
}
