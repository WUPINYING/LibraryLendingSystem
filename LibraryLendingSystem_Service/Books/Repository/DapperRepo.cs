﻿using Dapper;
using LibraryLendingSystem_Service.Books.Interface;
using LibraryLendingSystem_Service.Books.Models.Dtos;
using LibraryLendingSystem_Service.Models;
using Microsoft.Data.SqlClient;
using System.Data;

namespace LibraryLendingSystem_Service.Books.Repository
{
    public class DapperRepo:IDapperRepo
    {
        private string _connStr;
        public IConfiguration _configuration;

        public DapperRepo(IConfiguration configuration)
        {
            _configuration = configuration;
            _connStr = _configuration.GetConnectionString("AppDbContext");
        }

        public IEnumerable<BookDto> GetBooksList()
        {
            string sql = @"SELECT Book.[ISBN],[Name],[Author],[Introduction],[StatusName]
FROM Book
JOIN Inventory
ON Book.ISBN=Inventory.ISBN
JOIN LendStatus
ON Inventory.Status_Id=LendStatus.StatusId;";

            using IDbConnection dbConnection = new SqlConnection(_connStr);
            var result = dbConnection.Query<BookDto>(sql);
            return result;
        }

        public BorrowBookDto BorrowBook(BorrowBookDto dto)
        {
            string sql = @"INSERT INTO [BorrowingRecord] ([UserId], [InventoryId], [BorrowingTime], [ReturnTime])
VALUES (@userId, @inventoryId, GETDATE(), DATEADD(MONTH, 1, GETDATE()));";
            using IDbConnection dbConnection = new SqlConnection(_connStr);
            dbConnection.Query<BorrowBookDto>(sql, new { userId=dto.UserId, inventoryId=dto.InventoryId });
            return dto;
        }
    }
}
