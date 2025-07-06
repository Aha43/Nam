using Nam.Specification.Persistence.Abstraction;

namespace Nam.Specification.Persistence.Dbo;

public sealed class TagCategoryTagDbo : IDbo
{
    public int Id { get; set; }
    public int TagCategoryId { get; set; }
    public int TagId { get; set; }
    public DateTime CreatedAt { get; set; }
    public DateTime UpdatedAt { get; set; }
    public DateTime? DeletedAt { get; set; }
}
