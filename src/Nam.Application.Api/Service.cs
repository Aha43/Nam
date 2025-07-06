using Nam.Implementation.Persistence.Memory;
using Nam.Implementation.Business;
using Nam.Crosscutting.Abstraction;

namespace Nam.Application.Api;

internal static class Service
{
    public static IServiceCollection AddNamServices(this IServiceCollection services)
    {
        return services
            .AddScoped<IUserProvider, UserSetter>()
            .AddNamMemoryPersistenceServices()
            .AddNamBusinessServices();
    }
}
