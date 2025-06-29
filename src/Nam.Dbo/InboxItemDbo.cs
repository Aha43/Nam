using Nam.Dbo.Abstraction;

namespace Nam.Dbo;

public class InboxItemDbo : IDbo
{
    public int Id { get; init; }
    public required string Description { get; init; }
    public DateTime CreatedAt { get; init; }
    public DateTime UpdatedAt { get; init; }
    public DateTime? DeletedAt { get; init; }
}
