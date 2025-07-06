using Nam.Implementation.Persistence.Memory;
using Nam.Implementation.Business;

namespace Nam.Application.Api;

internal static class Service
{
    public static IServiceCollection AddNamServices(this IServiceCollection services)
    {
        return services
            .AddNamMemoryPersistenceServices()
            .AddNamBusinessServices();
    }
}
