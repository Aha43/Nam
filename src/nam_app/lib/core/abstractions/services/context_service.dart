import 'package:nam_app/core/entities/context.dart';

abstract class ContextService {
  Future<List<Context>> getContexts();
}
