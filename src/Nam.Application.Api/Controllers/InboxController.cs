using Microsoft.AspNetCore.Mvc;
using Nam.Specification.Business.Abstraction;
using Nam.Specification.Business.Dto;

namespace Nam.Application.Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class InboxController(IInboxService inboxService) : ControllerBase
    {
        [HttpGet("items")]
        public async Task<IActionResult> GetItemsAsync()
        {
            var inbox = await inboxService.GetItemsAsync();
            if (inbox == null)
                return StatusCode(StatusCodes.Status500InternalServerError, "Unexpected null inbox.");
            return Ok(inbox); // Empty list is a valid and common response
        }

        [HttpGet("items/{id}")]
        public async Task<IActionResult> GetItemAsync(int id)
        {
            var item = await inboxService.GetItemAsync(id);
            if (item == null) return NotFound();
            return Ok(item);
        }

        [HttpPost]
        public async Task<IActionResult> AddInboxItemAsync([FromBody] InboxItemDto item)
        {
            if (!ModelState.IsValid) return BadRequest(ModelState);
            var created = await inboxService.AddItemAsync(item);
            if (created == null)
                return StatusCode(StatusCodes.Status500InternalServerError, "Failed to add item.");
            return CreatedAtAction(nameof(GetItemAsync), new { id = created.Id }, created);
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteInboxItemAsync(int id)
        {
            var deleted = await inboxService.DeleteItemAsync(id);
            return deleted ? NoContent() : NotFound(); // Return 404 if item not found
        }

    }

}
