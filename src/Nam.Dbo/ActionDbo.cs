using Nam.Dbo.Abstraction;

namespace Nam.Dbo;

public class ActionDbo : IDbo
{
    public int Id { get; init; }
    public required string Description { get; init; }
    public required DateTime CreatedAt { get; init; }
    public DateTime UpdatedAt { get; init; }
    public DateTime? DeletedAt { get; init; } = null;
}
