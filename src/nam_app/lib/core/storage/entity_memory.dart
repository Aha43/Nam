import 'package:nam_app/core/abstractions/entity.dart';

class EntityMemory<T extends Entity> {
  final Map<String, T> _storage = {};

  void add(T entity) {
    if (_storage.containsKey(entity.getId())) {
      throw ArgumentError(
        '${T.toString()} with ID ${entity.getId()} already exists.',
      );
    }
    _storage[entity.getId()] = entity;
  }

  T? get(String id) {
    return _storage[id];
  }

  List<T> getAll() {
    return List.unmodifiable(_storage.values);
  } 

  void delete(String id) {
    if (!_storage.containsKey(id)) {
      throw ArgumentError(
        '${T.toString()} with ID $id does not exist.',
      );
    }
    _storage.remove(id);
  }

  void update(T entity) {
    if (!_storage.containsKey(entity.getId())) {
      throw ArgumentError(
        '${T.toString()} with ID ${entity.getId()} does not exist.',
      );
    }
    _storage[entity.getId()] = entity;
  }
}
