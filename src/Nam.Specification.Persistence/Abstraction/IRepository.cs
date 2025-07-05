using Nam.Specification.Persistence.Dbo;

namespace Nam.Specification.Persistence.Abstraction;

public interface IRepository<T> where T : IDbo
{
    Task<T?> GetByIdAsync(int id, CancellationToken cancellationToken = default);
    Task<IEnumerable<T>> GetAllAsync(CancellationToken cancellationToken = default);
    Task<T> AddAsync(T entity, CancellationToken cancellationToken = default);
    Task<T> UpdateAsync(T entity, CancellationToken cancellationToken = default);
    Task<bool> DeleteAsync(int id, CancellationToken cancellationToken = default);
}

public interface IActionRepository : IRepository<ActionDbo> { }
public interface IActionTagRepository : IRepository<ActionTagDbo> { }
public interface IContextRepository : IRepository<ContextDbo> { }
public interface IInboxItemRepository : IRepository<InboxItemDbo> { }
public interface IProjectActionRepository : IRepository<ProjectActionDbo> { }
public interface IProjectRepository : IRepository<ProjectDbo> { }
public interface ITagCategoryRepository : IRepository<TagCategoryDbo> { }
public interface ITagCategoryTagRepository : IRepository<TagCategoryTagDbo> { }
public interface ITagRepository : IRepository<TagDbo> { }
public interface ITagProjectRepository : IRepository<TagProjectDbo> { }
