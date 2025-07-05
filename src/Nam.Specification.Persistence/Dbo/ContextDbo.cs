using Nam.Specification.Persistence.Abstraction;

namespace Nam.Specification.Persistence.Dbo;

public class ContextDbo : IDbo
{
    public int Id { get; init; }
    public required string Name { get; init; }
    public DateTime CreatedAt { get; init; }
    public DateTime UpdatedAt { get; init; }
    public DateTime? DeletedAt { get; init; }
}
