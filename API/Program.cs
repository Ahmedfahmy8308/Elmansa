
using API.Data;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;

namespace API
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var builder = WebApplication.CreateBuilder(args);

            // Add services to the container.
            builder.Services.AddIdentity<AppUser, IdentityRole>(op =>
                {
                    op.Password.RequireDigit = false;
                    op.Password.RequireLowercase = false;
                    op.Password.RequireUppercase = false;
                    op.Password.RequireNonAlphanumeric = false;
                    op.Password.RequiredLength = 6;
                }
                ).AddEntityFrameworkStores<AppDbContext>();

            builder.Services.AddControllers();
            builder.Services.AddDbContext<AppDbContext>(options =>
            {
                options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection"));
            });
            // Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
            builder.Services.AddEndpointsApiExplorer();
            builder.Services.AddSwaggerGen();

            var context = builder.Services.BuildServiceProvider().GetService<AppDbContext>();
            context.Database.EnsureCreated();
            //context.Database.Migrate();
            //context.Database.EnsureDeleted();

            //var sql = context.Database.GenerateCreateScript();
            //Console.WriteLine(sql);

            var app = builder.Build();

            // Configure the HTTP request pipeline.
            if (app.Environment.IsDevelopment())
            {
                app.UseSwagger();
                app.UseSwaggerUI();
            }
            app.UseStaticFiles();
            app.UseAuthorization();


            app.MapControllers();

            app.Run();

        }
    }
}
