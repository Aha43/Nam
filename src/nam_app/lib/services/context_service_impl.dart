import 'package:nam_app/core/abstractions/services/context_service.dart';
import 'package:nam_app/core/entities/context.dart';

class InMemoryContextService implements ContextService {
  final List<Context> _contexts = [
    Context(
      id: '1',
      name: 'Work',
      tags: ['work'],
      ruleFunction: atLeastOneTag, // Use the rule function
    ),
    Context(
      id: '2',
      name: 'Home',
      tags: ['home'],
      ruleFunction: allTagsMatch, // Use the rule function
    ),
    Context(
      id: '3',
      name: 'Errands',
      tags: ['errand'],
      ruleFunction: atLeastOneTag, // Use the rule function
    ),
  ];

  @override
  Future<List<Context>> getContexts() async {
    return _contexts;
  }
}
