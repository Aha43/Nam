using Microsoft.Extensions.Logging;
using Nam.Specification.Business.Abstraction;
using Nam.Specification.Business.Dto;
using Nam.Specification.Persistence.Abstraction;
using Nam.Specification.Persistence.Dbo;

namespace Nam.Implementation.Business;

public sealed class InboxService(
    IInboxItemRepository inboxItemRepository,
    ILogger<InboxService> logger
) : IInboxService
{
    public async Task<InboxItemDto> AddItemAsync(InboxItemDto item, CancellationToken cancellationToken = default)
    {
        logger.LogInformation("Adding item to inbox: {Description}", item.Description);

        var inboxItem = new InboxItemDbo
        {
            Description = item.Description
        };

        var addedItem = await inboxItemRepository.AddAsync(inboxItem, cancellationToken);
        
        logger.LogInformation("Added item to inbox with ID: {Id}", addedItem.Id);

        return new InboxItemDto
        {
            Id = addedItem.Id,
            Description = addedItem.Description
        };
    }

    public async Task<bool> DeleteItemAsync(int itemId, CancellationToken cancellationToken = default)
    {
        logger.LogInformation("Deleting item from inbox with ID: {Id}", itemId);

        var deleted = await inboxItemRepository.DeleteAsync(itemId, cancellationToken);

        if (!deleted)
        {
            logger.LogWarning("Item with ID: {Id} not found in inbox for deletion", itemId);
            return false;
        }

        logger.LogInformation("Deleted item from inbox with ID: {Id}", itemId);
        return true;
    }

    public async Task<InboxItemDto?> GetItemAsync(int itemId, CancellationToken cancellationToken = default)
    {
        logger.LogInformation("Retrieving item from inbox with ID: {Id}", itemId);

        var item = await inboxItemRepository.GetByIdAsync(itemId, cancellationToken);
        
        if (item == null)
        {
            logger.LogWarning("Item with ID: {Id} not found in inbox", itemId);
            return null;
        }

        logger.LogInformation("Retrieved item from inbox with ID: {Id}", item.Id);

        return new InboxItemDto
        {
            Id = item.Id,
            Description = item.Description
        };
    }

    public async Task<IEnumerable<InboxItemDto>> GetItemsAsync(CancellationToken cancellationToken = default)
    {
        logger.LogInformation("Retrieving inbox items");

        var inboxItems = await inboxItemRepository.GetAllAsync(cancellationToken);

        if (inboxItems == null || !inboxItems.Any())
        {
            logger.LogInformation("No items found in inbox");
            return [];
        }
        
        logger.LogInformation("Retrieved {Count} items from inbox", inboxItems.Count());

        return inboxItems.Select(item => new InboxItemDto
        {
            Id = item.Id,
            Description = item.Description
        });
    }

    public async Task<InboxItemDto> UpdateItemAsync(InboxItemDto item, CancellationToken cancellationToken = default)
    {
        logger.LogInformation("Updating item in inbox with ID: {Id}", item.Id);

        var existingItem = await inboxItemRepository.GetByIdAsync(item.Id, cancellationToken);
        if (existingItem == null)
        {
            logger.LogWarning("Item with ID: {Id} not found in inbox", item.Id);
            throw new KeyNotFoundException($"Item with ID {item.Id} not found.");
        }

        var itemUpdated = new InboxItemDbo
        {
            Id = existingItem.Id,
            Description = item.Description
        };

        var updatedItem = await inboxItemRepository.UpdateAsync(itemUpdated, cancellationToken);

        logger.LogInformation("Updated item in inbox with ID: {Id}", updatedItem.Id);

        return new InboxItemDto
        {
            Id = updatedItem.Id,
            Description = updatedItem.Description
        };
    }
}
