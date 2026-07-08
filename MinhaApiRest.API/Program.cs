using System;
using Microsoft.EntityFrameworkCore;
using MinhaApiRest.Infra.Data;

var builder = WebApplication.CreateBuilder(args);

var envConn = Environment.GetEnvironmentVariable("ConnectionStrings__DefaultConnection");
var connectionString = !string.IsNullOrWhiteSpace(envConn)
    ? envConn
    : builder.Configuration.GetConnectionString("DefaultConnection");


if (string.IsNullOrWhiteSpace(connectionString))
{
    Console.Error.WriteLine("[ERROR] Connection string 'DefaultConnection' not found.");
    return;
}

ServerVersion serverVersion;
try
{
    serverVersion = ServerVersion.AutoDetect(connectionString);
}
catch (Exception ex)
{
    Console.Error.WriteLine($"[ERROR] Could not detect MySQL server version: {ex.Message}");
    throw;
}

builder.Services.AddDbContext<AppDbContext>(options =>
    options.UseMySql(connectionString, serverVersion));

builder.Services.AddControllers();

var app = builder.Build();

app.MapControllers();
app.Run();