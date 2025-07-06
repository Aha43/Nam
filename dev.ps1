function build {
    dotnet build
}

function start-api {
    dotnet run --project ./src/Nam.Application.Api/Nam.Application.Api.csproj
}

function swagger {
    Start-Process "http://localhost:5190/swagger"
}

function help {
    Write-Host "Available commands:"
    Write-Host "  build - Build the project"
    Write-Host "  start-api - Start the API project"
    Write-Host "  swagger - Open Swagger UI in the browser"
    Write-Host "  help - Show this help message"
}