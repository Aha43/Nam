namespace Nam.Specification.Business.Dto;

public class InboxDto
{
    public IEnumerable<InboxItemDto> Items { get; init; } = null!;
}
