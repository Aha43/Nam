// Generic CRUD Repository Interface
abstract class Repository<T> {
  Future<List<T>> getAll();
  Future<T?> getById(String id);
  Future<void> add(T entity);
  Future<void> update(T entity);
  Future<void> delete(String id);
}