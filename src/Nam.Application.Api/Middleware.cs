using Nam.Crosscutting.Abstraction;

namespace Nam.Application.Api;

public class UserSetter : IUserProvider
{
    private string? _userId;

    public void SetUserId(string userId) => _userId = userId;

    public string GetUserId()
    {
        if (_userId == null)
        {
            throw new InvalidOperationException("User ID has not been set.");
        }
        return _userId;
    }
}

public class UserContextMiddleware(RequestDelegate next)
{
    public async Task Invoke(HttpContext context, IUserProvider userProvider)
    {
        if (userProvider is not UserSetter userSetter)
        {
            throw new InvalidOperationException("UserProvider is not of type UserSetter.");
        }

        var userId = context.User?.FindFirst("sub")?.Value;
        if (userId != null) userSetter.SetUserId(userId);
        await next(context);
    }
}

public static class MiddlewareExtensions
{
    public static IApplicationBuilder UseUserContext(this IApplicationBuilder builder)
        => builder.UseMiddleware<UserContextMiddleware>();
}
