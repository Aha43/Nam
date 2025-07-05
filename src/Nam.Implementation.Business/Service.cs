using Microsoft.Extensions.DependencyInjection;
using Nam.Specification.Business.Abstraction;

namespace Nam.Implementation.Business;

public static class Service
{
    public static IServiceCollection AddBusinessServices(this IServiceCollection services)
    {
        return services.AddScoped<IInboxService, InboxService>();
    }
}
