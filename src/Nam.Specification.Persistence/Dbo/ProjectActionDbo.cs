using Nam.Specification.Persistence.Abstraction;

namespace Nam.Specification.Persistence.Dbo;

public sealed class ProjectActionDbo : IDbo
{
    public int Id { get; set; }
    public int ProjectId { get; set; }
    public int ActionId { get; set; }
    public DateTime CreatedAt { get; set; }
    public DateTime UpdatedAt { get; set; }
    public DateTime? DeletedAt { get; set; }
}
