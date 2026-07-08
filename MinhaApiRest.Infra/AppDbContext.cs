using Microsoft.EntityFrameworkCore;
namespace MinhaApiRest.Infra.Data;

public class AppDbContext : DbContext
{
    public AppDbContext(DbContextOptions<AppDbContext> options) : base(options)
    {
    }

}
