import 'package:nam_app/core/entities/tag.dart';
import 'package:nam_app/core/entities/action.dart';
import 'package:nam_app/core/entities/project.dart';
import 'package:nam_app/core/entities/context.dart';
import 'package:nam_app/core/entities/inbox_item.dart';
import 'package:nam_app/core/abstractions/repository.dart';

// Abstract Repository for Tag
abstract class TagRepository extends Repository<Tag> {
  // Example custom operation
  Future<Tag?> get ByName(String name);
}

// Abstract Repository for Action
abstract class ActionRepository extends Repository<Action> {}

// Abstract Repository for Project
abstract class ProjectRepository extends Repository<Project> {}

// Abstract Repository for Context
abstract class ContextRepository extends Repository<Context> {}

// Abstract Repository for InboxItem
abstract class InboxItemRepository extends Repository<InboxItem> {}
