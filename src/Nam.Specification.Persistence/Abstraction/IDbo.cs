namespace Nam.Specification.Persistence.Abstraction;

public interface IDbo
{
    int Id { get; }
    public DateTime CreatedAt { get; }
    public DateTime UpdatedAt { get; }
    public DateTime? DeletedAt { get; } 
}
