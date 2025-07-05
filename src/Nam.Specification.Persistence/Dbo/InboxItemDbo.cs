using Nam.Specification.Persistence.Abstraction;

namespace Nam.Specification.Persistence.Dbo;

public class InboxItemDbo : IDbo
{
    public int Id { get; init; }
    public string Description { get; init; } = null!;
    public DateTime CreatedAt { get; init; }
    public DateTime UpdatedAt { get; init; }
    public DateTime? DeletedAt { get; init; }
}
