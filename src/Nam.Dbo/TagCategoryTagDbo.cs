using Nam.Dbo.Abstraction;

namespace Nam.Dbo;

public class TagCategoryTagDbo : IDbo
{
    public int Id { get; init; }
    public int TagCategoryId { get; init; }
    public int TagId { get; init; }
    public DateTime CreatedAt { get; init; }
    public DateTime UpdatedAt { get; init; }
    public DateTime? DeletedAt { get; init; }
}
