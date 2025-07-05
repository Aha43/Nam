using Nam.Specification.Business.Dto;

namespace Nam.Specification.Business.Abstraction;

public interface IInboxService
{
    /// <summary>
    ///     Gets the inbox.
    /// </summary>
    /// <param name="cancellationToken">The cancellation token.</param>
    /// <returns>The inbox.</returns>
    Task<IEnumerable<InboxItemDto>> GetItemsAsync(CancellationToken cancellationToken = default);

    /// <summary>
    ///     Gets a specific item from the inbox.
    /// </summary>
    /// <param name="itemId">The ID of the item to retrieve.</param>
    /// <param name="cancellationToken">The cancellation token.</param>
    /// <returns>The item if found, otherwise null.</returns>
    Task<InboxItemDto?> GetItemAsync(int itemId, CancellationToken cancellationToken = default);

    /// <summary>
    ///     Adds an item to the inbox.
    /// </summary>
    /// <param name="item">The item to add.</param>
    /// <param name="cancellationToken">The cancellation token.</param>
    /// <returns>The added item.</returns>
    Task<InboxItemDto> AddItemAsync(InboxItemDto item, CancellationToken cancellationToken = default);

    /// <summary>
    ///     Updates an existing item in the inbox.
    /// </summary>
    /// <param name="item"></param>
    /// <param name="cancellationToken"></param>
    /// <returns>The updated item.</returns>
    Task<InboxItemDto> UpdateItemAsync(InboxItemDto item, CancellationToken cancellationToken = default);

    /// <summary>
    ///     Deletes an item from the inbox.
    /// </summary>
    /// <param name="itemId">The ID of the item to delete.</param>
    /// <param name="cancellationToken">The cancellation token.</param>
    /// <returns>True if the item was deleted, otherwise false.</returns>
    Task<bool> DeleteItemAsync(int itemId, CancellationToken cancellationToken = default);
}
