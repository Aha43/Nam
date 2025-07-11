using Nam.Application.Api;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllers();
builder.Services
    .AddOpenApi()
    .AddSwaggerGen()
    .AddNamServices();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.MapOpenApi();

    app.UseSwaggerUI(c =>
    {
        app.UseSwagger();
        app.UseSwaggerUI();
    });
}

app.UseUserContext();

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
