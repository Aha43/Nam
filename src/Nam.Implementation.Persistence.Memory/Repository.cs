using Nam.Crosscutting.Abstraction;
using Nam.Specification.Persistence.Abstraction;
using Nam.Specification.Persistence.Dbo;

namespace Nam.Implementation.Persistence.Memory;

public class Repository<T>(
    IUserProvider userProvider,
    Action<T, int> setId) : IRepository<T> where T : IDbo
{
    private readonly Dictionary<string, MemoryStorage<T>> _storage = [];

    public Task<T> AddAsync(T entity, CancellationToken cancellationToken = default)
    {
        var storage = GetStorage();
        setId(entity, storage.Items.Count > 0 ? storage.Items.Keys.Max() + 1 : 1); // Simple ID generation
        storage.Items[entity.Id] = entity;
        return Task.FromResult(entity);
    }

    public Task<bool> DeleteAsync(int id, CancellationToken cancellationToken = default)
    {
        var storage = GetStorage();
        if (storage.Items.Remove(id)) return Task.FromResult(true);
        return Task.FromResult(false);
    }

    public Task<IEnumerable<T>> GetAllAsync(CancellationToken cancellationToken = default)
    {
        var storage = GetStorage();
        return Task.FromResult<IEnumerable<T>>(storage.Items.Values);
    }

    public Task<T?> GetByIdAsync(int id, CancellationToken cancellationToken = default)
    {
        var storage = GetStorage();
        storage.Items.TryGetValue(id, out var entity);
        return Task.FromResult(entity);
    }

    public Task<T> UpdateAsync(T entity, CancellationToken cancellationToken = default)
    {
        var storage = GetStorage();
        if (!storage.Items.ContainsKey(entity.Id))
        {
            throw new KeyNotFoundException($"Entity with ID {entity.Id} not found.");
        }
        storage.Items[entity.Id] = entity;
        return Task.FromResult(entity);
    }

    private MemoryStorage<T> GetStorage()
    {
        var userId = userProvider.GetUserId();
        if (!_storage.TryGetValue(userId, out var storage))
        {
            storage = new MemoryStorage<T>();
            _storage[userId] = storage;
        }
        return storage;
    }

}

internal sealed class InboxItemRepository(IUserProvider userProvider)
    : Repository<InboxItemDbo>(userProvider, (item, id) => item.Id = id), IInboxItemRepository
{
}
