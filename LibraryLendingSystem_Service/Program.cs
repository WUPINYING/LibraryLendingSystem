using LibraryLendingSystem_Service.Books.Interface;
using LibraryLendingSystem_Service.Books.Repository;
using LibraryLendingSystem_Service.Models;
using Microsoft.AspNetCore.Builder;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddControllers();

// Add services to the DI container.
//string LibraryLendingSystemConnectionString = builder.Configuration.GetConnectionString("LibraryLendingSystem");
//builder.Services.AddDbContext<AppDbContext>(options =>
//{
//    options.UseSqlServer(LibraryLendingSystemConnectionString);
//});

builder.Services.AddDbContext<AppDbContext>(options =>
{
    options.UseSqlServer(builder.Configuration.GetConnectionString("AppDbContext"));
});

//CORS
string myAllowOrigins = "AllowAny";
builder.Services.AddCors(options =>
{
    options.AddPolicy(
        name: myAllowOrigins, policy => policy.WithOrigins("*").WithHeaders("*").WithMethods("*")
        );
});

//Dapper
builder.Services.AddScoped<IDapperRepo, DapperRepo>();

// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseCors();
app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
