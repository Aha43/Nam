using Microsoft.Extensions.DependencyInjection;
using Nam.Specification.Persistence.Abstraction;

namespace Nam.Implementation.Business;

public static class Service
{
    public static IServiceCollection AddBusinessServices(this IServiceCollection services)
    {
        return services.AddScoped<IInboxItemRepository, InboxService>();
    }
}
