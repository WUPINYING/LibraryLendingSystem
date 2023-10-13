using LibraryLendingSystem_Service.Books.Interface;
using LibraryLendingSystem_Service.Books.Repository;
using LibraryLendingSystem_Service.Members.Interface;
using LibraryLendingSystem_Service.Members.Repository;
using LibraryLendingSystem_Service.Models;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddControllers();

builder.Services.AddDbContext<AppDbContext>(options =>
{
    options.UseSqlServer(builder.Configuration.GetConnectionString("AppDbContext"));
});

//CORS
string myAllowOrigins = "AllowAny";
builder.Services.AddCors(options =>
{
    options.AddPolicy(
        name: myAllowOrigins, policy => policy.WithOrigins("*").WithHeaders("*").WithMethods("*"));
});

//Dapper
builder.Services.AddScoped<IDapperRepo, DapperRepo>();
builder.Services.AddScoped<IMemberDapperRepo, MemberDapperRepo>();

//Cookie
builder.Services.AddAuthentication(CookieAuthenticationDefaults.AuthenticationScheme).AddCookie(option =>
{
    option.ExpireTimeSpan = TimeSpan.FromMinutes(60);
    option.LoginPath = "/api/Members/Login";
});

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

app.UseCookiePolicy();

app.UseHttpsRedirection();

app.UseAuthentication();

app.UseAuthorization();

app.MapControllers();

app.Run();
