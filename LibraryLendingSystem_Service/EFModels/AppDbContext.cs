﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
#nullable disable
using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

namespace LibraryLendingSystem_Service.Models
{
    public partial class AppDbContext : DbContext
    {
        public AppDbContext()
        {
        }

        public AppDbContext(DbContextOptions<AppDbContext> options)
            : base(options)
        {
        }

        public virtual DbSet<Book> Book { get; set; }
        public virtual DbSet<BorrowingRecord> BorrowingRecord { get; set; }
        public virtual DbSet<Inventory> Inventory { get; set; }
        public virtual DbSet<LendStatus> LendStatus { get; set; }
        public virtual DbSet<Users> Users { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see http://go.microsoft.com/fwlink/?LinkId=723263.
                optionsBuilder.UseSqlServer("Data Source=.;Initial Catalog=LibraryLendingSystem;Integrated Security=True");
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Book>(entity =>
            {
                entity.HasKey(e => e.Isbn);

                entity.Property(e => e.Isbn)
                    .HasMaxLength(13)
                    .HasColumnName("ISBN");

                entity.Property(e => e.Author)
                    .IsRequired()
                    .HasMaxLength(30);

                entity.Property(e => e.Introduction)
                    .IsRequired()
                    .HasMaxLength(300);

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasMaxLength(30);
            });

            modelBuilder.Entity<BorrowingRecord>(entity =>
            {
                entity.HasNoKey();

                entity.HasIndex(e => e.InventoryId, "IX_BorrowingRecord_InventoryId");

                entity.HasIndex(e => e.UserId, "IX_BorrowingRecord_UserId");

                entity.Property(e => e.BorrowingTime).HasColumnType("datetime");

                entity.Property(e => e.ReturnTime).HasColumnType("datetime");
            });

            modelBuilder.Entity<Inventory>(entity =>
            {
                entity.Property(e => e.Isbn)
                    .IsRequired()
                    .HasMaxLength(13)
                    .HasColumnName("ISBN");

                entity.Property(e => e.StatusId).HasColumnName("Status_Id");

                entity.Property(e => e.StoreTime).HasColumnType("date");
            });

            modelBuilder.Entity<LendStatus>(entity =>
            {
                entity.HasKey(e => e.StatusId)
                    .HasName("PK_Status");

                entity.Property(e => e.StatusName)
                    .IsRequired()
                    .HasMaxLength(10);
            });

            modelBuilder.Entity<Users>(entity =>
            {
                entity.HasKey(e => e.UserId)
                    .HasName("PK_User");

                entity.HasIndex(e => e.PhoneNumber, "IX_User_phone")
                    .IsUnique();

                entity.Property(e => e.LastLoginTime).HasColumnType("datetime");

                entity.Property(e => e.Password)
                    .IsRequired()
                    .HasMaxLength(10)
                    .IsUnicode(false);

                entity.Property(e => e.PhoneNumber)
                    .IsRequired()
                    .HasMaxLength(10)
                    .IsFixedLength();

                entity.Property(e => e.RegistrationTime).HasColumnType("datetime");

                entity.Property(e => e.UserName)
                    .IsRequired()
                    .HasMaxLength(10);
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}