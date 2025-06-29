using Nam.Data.Specification.Abstraction;

namespace Nam.Data.Specification;

public class InboxItemDbo : IDbo
{
    public int Id { get; init; }
    public required string Description { get; init; }
    public DateTime CreatedAt { get; init; }
    public DateTime UpdatedAt { get; init; }
    public DateTime? DeletedAt { get; init; }
}
