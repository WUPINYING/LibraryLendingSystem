using Dapper;
using LibraryLendingSystem_Service.Members.Interface;
using LibraryLendingSystem_Service.Members.Models.Dtos;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using System.Data;

namespace LibraryLendingSystem_Service.Members.Repository
{
    public class MemberDapperRepo: IMemberDapperRepo
    {
        private string _connStr;
        public IConfiguration _configuration;

        public MemberDapperRepo(IConfiguration configuration)
        {
            _configuration = configuration;
            _connStr = _configuration.GetConnectionString("AppDbContext");
        }

        public RegisterDto Register(RegisterDto dto)
        {
            string sql = @"INSERT INTO [Users]
VALUES (@phoneNumber,@password,'User11',GETDATE(),'2023-10-19 06:15:00');";
            using IDbConnection dbConnection = new SqlConnection(_connStr);
            dbConnection.Query<RegisterDto>(sql, new { phoneNumber = dto.PhoneNumber, password = dto.Password });
            return dto;
        }

        public void Login(RegisterDto dto)
        {
            string sql = @"UPDATE [Users]
SET LastLoginTime = GETDATE()
WHERE PhoneNumber = @phoneNumber;";
            using IDbConnection dbConnection = new SqlConnection(_connStr);
            dbConnection.Query<RegisterDto>(sql, new { phoneNumber = dto.PhoneNumber});
        }
    }
}
