using Nam.Dbo.Abstraction;

namespace Nam.Dbo;

public class TagCategoryDbo : IDbo
{
    public int Id { get; init; }
    public required string Name { get; init; }
    public DateTime CreatedAt { get; init; }
    public DateTime UpdatedAt { get; init; }
    public DateTime? DeletedAt { get; init; }
}
