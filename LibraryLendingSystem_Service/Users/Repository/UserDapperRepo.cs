using Dapper;
using LibraryLendingSystem_Service.Books.Models.Dtos;
using LibraryLendingSystem_Service.Users.Models.Dtos;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using System.Data;

namespace LibraryLendingSystem_Service.Users.Repository
{
    public class UserDapperRepo
    {
        private string _connStr;
        public IConfiguration _configuration;

        public UserDapperRepo(IConfiguration configuration)
        {
            _configuration = configuration;
            _connStr = _configuration.GetConnectionString("AppDbContext");
        }
        public RegisterDto Register(RegisterDto dto)
        {
            string sql = @"INSERT INTO [User]
VALUES ('@phoneNumber','@password','User11',GETDATE(),'2023-10-19 06:15:00');";
            using IDbConnection dbConnection = new SqlConnection(_connStr);
            dbConnection.Query<RegisterDto>(sql, new { phoneNumber = dto.PhoneNumber, password = dto.Password });
            return dto;
        }
    }
}
