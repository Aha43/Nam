using Nam.Specification.Persistence.Abstraction;

namespace Nam.Implementation.Persistence.Memory;

internal class MemoryStorage<T> where T : IDbo
{
    public Dictionary<int, T> Items { get; } = [];
}
