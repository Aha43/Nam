using Nam.Specification.Persistence.Abstraction;

namespace Nam.Specification.Persistence.Dbo;

public class TagProjectDbo : IDbo
{
    public int Id { get; init; }
    public int ProjectId { get; init; }
    public int TagId { get; init; }
    public DateTime CreatedAt { get; init; }
    public DateTime UpdatedAt { get; init; }
    public DateTime? DeletedAt { get; init; }
}
