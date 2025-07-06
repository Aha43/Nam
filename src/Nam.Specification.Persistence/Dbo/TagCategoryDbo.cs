using Nam.Specification.Persistence.Abstraction;

namespace Nam.Specification.Persistence.Dbo;

public sealed class TagCategoryDbo : IDbo
{
    public int Id { get; set; }
    public required string Name { get; set; }
    public DateTime CreatedAt { get; set; }
    public DateTime UpdatedAt { get; set; }
    public DateTime? DeletedAt { get; set; }
}
