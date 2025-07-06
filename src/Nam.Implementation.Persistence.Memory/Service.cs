using Nam.Specification.Persistence.Abstraction;
using Microsoft.Extensions.DependencyInjection;

namespace Nam.Implementation.Persistence.Memory;

public static class Service
{
    public static IServiceCollection AddNamMemoryPersistenceServices(this IServiceCollection services)
    {
        return services
            .AddSingleton<IInboxItemRepository, InboxItemRepository>();
    }
}
