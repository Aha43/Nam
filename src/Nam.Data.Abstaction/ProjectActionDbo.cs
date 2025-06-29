using Nam.Data.Specification.Abstraction;

namespace Nam.Data.Specification;

public class ProjectActionDbo : IDbo
{
    public int Id { get; init; }
    public int ProjectId { get; init; }
    public int ActionId { get; init; }
    public DateTime CreatedAt { get; init; }
    public DateTime UpdatedAt { get; init; }
    public DateTime? DeletedAt { get; init; }
}
