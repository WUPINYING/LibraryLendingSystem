USE [master]
GO
/****** Object:  Database [LibraryLendingSystem]    Script Date: 2023/10/13 下午 11:40:05 ******/
CREATE DATABASE [LibraryLendingSystem]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BookLendingSystem', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\BookLendingSystem.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'BookLendingSystem_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\BookLendingSystem_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [LibraryLendingSystem] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [LibraryLendingSystem].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [LibraryLendingSystem] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [LibraryLendingSystem] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [LibraryLendingSystem] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [LibraryLendingSystem] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [LibraryLendingSystem] SET ARITHABORT OFF 
GO
ALTER DATABASE [LibraryLendingSystem] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [LibraryLendingSystem] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [LibraryLendingSystem] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [LibraryLendingSystem] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [LibraryLendingSystem] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [LibraryLendingSystem] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [LibraryLendingSystem] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [LibraryLendingSystem] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [LibraryLendingSystem] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [LibraryLendingSystem] SET  DISABLE_BROKER 
GO
ALTER DATABASE [LibraryLendingSystem] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [LibraryLendingSystem] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [LibraryLendingSystem] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [LibraryLendingSystem] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [LibraryLendingSystem] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [LibraryLendingSystem] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [LibraryLendingSystem] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [LibraryLendingSystem] SET RECOVERY FULL 
GO
ALTER DATABASE [LibraryLendingSystem] SET  MULTI_USER 
GO
ALTER DATABASE [LibraryLendingSystem] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [LibraryLendingSystem] SET DB_CHAINING OFF 
GO
ALTER DATABASE [LibraryLendingSystem] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [LibraryLendingSystem] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [LibraryLendingSystem] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [LibraryLendingSystem] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'LibraryLendingSystem', N'ON'
GO
ALTER DATABASE [LibraryLendingSystem] SET QUERY_STORE = OFF
GO
USE [LibraryLendingSystem]
GO
/****** Object:  Table [dbo].[Book]    Script Date: 2023/10/13 下午 11:40:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Book](
	[ISBN] [nvarchar](13) NOT NULL,
	[Name] [nvarchar](30) NOT NULL,
	[Author] [nvarchar](30) NOT NULL,
	[Introduction] [nvarchar](300) NOT NULL,
 CONSTRAINT [PK_Book] PRIMARY KEY CLUSTERED 
(
	[ISBN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BorrowingRecord]    Script Date: 2023/10/13 下午 11:40:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BorrowingRecord](
	[UserId] [int] NOT NULL,
	[InventoryId] [int] NOT NULL,
	[BorrowingTime] [datetime] NOT NULL,
	[ReturnTime] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Inventory]    Script Date: 2023/10/13 下午 11:40:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Inventory](
	[InventoryId] [int] IDENTITY(1,1) NOT NULL,
	[ISBN] [nvarchar](13) NOT NULL,
	[StoreTime] [date] NOT NULL,
	[Status_Id] [int] NOT NULL,
 CONSTRAINT [PK_Inventory] PRIMARY KEY CLUSTERED 
(
	[InventoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LendStatus]    Script Date: 2023/10/13 下午 11:40:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LendStatus](
	[StatusId] [int] IDENTITY(1,1) NOT NULL,
	[StatusName] [nvarchar](10) NOT NULL,
 CONSTRAINT [PK_Status] PRIMARY KEY CLUSTERED 
(
	[StatusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 2023/10/13 下午 11:40:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[PhoneNumber] [nchar](10) NOT NULL,
	[Password] [varchar](300) NOT NULL,
	[UserName] [nvarchar](10) NOT NULL,
	[RegistrationTime] [datetime] NOT NULL,
	[LastLoginTime] [datetime] NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Book] ([ISBN], [Name], [Author], [Introduction]) VALUES (N'9780060850524', N'Pride and Prejudice', N'Jane Austen', N'A classic romance novel.')
GO
INSERT [dbo].[Book] ([ISBN], [Name], [Author], [Introduction]) VALUES (N'9780061120084', N'To Kill a Mockingbird', N'George Orwell', N'A dystopian novel about surveillance and control.')
GO
INSERT [dbo].[Book] ([ISBN], [Name], [Author], [Introduction]) VALUES (N'9780062075807', N'1984', N'George Orwell', N'A dystopian novel about a totalitarian regime.')
GO
INSERT [dbo].[Book] ([ISBN], [Name], [Author], [Introduction]) VALUES (N'9780141439563', N'Frankenstein', N'Mary Shelley', N'A tale of scientific experimentation and the consequences.')
GO
INSERT [dbo].[Book] ([ISBN], [Name], [Author], [Introduction]) VALUES (N'9780307588364', N'The Great Gatsby', N'F. Scott Fitzgerald', N'The story of Jay Gatsby and the Roaring Twenties.')
GO
INSERT [dbo].[Book] ([ISBN], [Name], [Author], [Introduction]) VALUES (N'9780451169510', N'To Kill a Mockingbird', N'Harper Lee', N'A classic novel set in the American South.')
GO
INSERT [dbo].[Book] ([ISBN], [Name], [Author], [Introduction]) VALUES (N'9780544003415', N'The Hobbit', N'J.R.R. Tolkien', N'The adventures of Bilbo Baggins.')
GO
INSERT [dbo].[Book] ([ISBN], [Name], [Author], [Introduction]) VALUES (N'9780743273500', N'The Catcher in the Rye', N'J.D. Salinger', N'The coming-of-age story of Holden Caulfield.')
GO
INSERT [dbo].[Book] ([ISBN], [Name], [Author], [Introduction]) VALUES (N'9780743273511', N'The Catcher in the Rye', N'J.D. Salinger', N'The coming-of-age story of Holden Caulfield.')
GO
INSERT [dbo].[Book] ([ISBN], [Name], [Author], [Introduction]) VALUES (N'9780743273565', N'The Catcher in the Rye', N'J.D. Salinger', N'The coming-of-age story of Holden Caulfield.')
GO
INSERT [dbo].[BorrowingRecord] ([UserId], [InventoryId], [BorrowingTime], [ReturnTime]) VALUES (1, 3, CAST(N'2023-10-01T10:00:00.000' AS DateTime), CAST(N'2023-10-10T15:00:00.000' AS DateTime))
GO
INSERT [dbo].[BorrowingRecord] ([UserId], [InventoryId], [BorrowingTime], [ReturnTime]) VALUES (1, 2, CAST(N'2023-10-02T11:00:00.000' AS DateTime), CAST(N'2023-10-11T14:30:00.000' AS DateTime))
GO
INSERT [dbo].[BorrowingRecord] ([UserId], [InventoryId], [BorrowingTime], [ReturnTime]) VALUES (3, 1, CAST(N'2023-10-03T12:00:00.000' AS DateTime), CAST(N'2023-10-12T13:45:00.000' AS DateTime))
GO
INSERT [dbo].[BorrowingRecord] ([UserId], [InventoryId], [BorrowingTime], [ReturnTime]) VALUES (3, 9, CAST(N'2023-10-04T13:00:00.000' AS DateTime), CAST(N'2023-10-13T12:15:00.000' AS DateTime))
GO
INSERT [dbo].[BorrowingRecord] ([UserId], [InventoryId], [BorrowingTime], [ReturnTime]) VALUES (24, 7, CAST(N'2023-10-13T23:21:06.793' AS DateTime), CAST(N'2023-11-13T23:21:06.793' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[Inventory] ON 
GO
INSERT [dbo].[Inventory] ([InventoryId], [ISBN], [StoreTime], [Status_Id]) VALUES (1, N'9780451169510', CAST(N'2023-09-20' AS Date), 1)
GO
INSERT [dbo].[Inventory] ([InventoryId], [ISBN], [StoreTime], [Status_Id]) VALUES (2, N'9780307588364', CAST(N'2023-09-20' AS Date), 2)
GO
INSERT [dbo].[Inventory] ([InventoryId], [ISBN], [StoreTime], [Status_Id]) VALUES (3, N'9780061120084', CAST(N'2023-09-20' AS Date), 3)
GO
INSERT [dbo].[Inventory] ([InventoryId], [ISBN], [StoreTime], [Status_Id]) VALUES (4, N'9780743273565', CAST(N'2023-09-20' AS Date), 4)
GO
INSERT [dbo].[Inventory] ([InventoryId], [ISBN], [StoreTime], [Status_Id]) VALUES (5, N'9780060850524', CAST(N'2023-09-20' AS Date), 5)
GO
INSERT [dbo].[Inventory] ([InventoryId], [ISBN], [StoreTime], [Status_Id]) VALUES (6, N'9780062075807', CAST(N'2023-09-20' AS Date), 6)
GO
INSERT [dbo].[Inventory] ([InventoryId], [ISBN], [StoreTime], [Status_Id]) VALUES (7, N'9780544003415', CAST(N'2023-09-20' AS Date), 1)
GO
INSERT [dbo].[Inventory] ([InventoryId], [ISBN], [StoreTime], [Status_Id]) VALUES (8, N'9780141439563', CAST(N'2023-09-20' AS Date), 1)
GO
INSERT [dbo].[Inventory] ([InventoryId], [ISBN], [StoreTime], [Status_Id]) VALUES (9, N'9780743273565', CAST(N'2023-09-20' AS Date), 1)
GO
INSERT [dbo].[Inventory] ([InventoryId], [ISBN], [StoreTime], [Status_Id]) VALUES (10, N'9780743273565', CAST(N'2023-09-20' AS Date), 1)
GO
SET IDENTITY_INSERT [dbo].[Inventory] OFF
GO
SET IDENTITY_INSERT [dbo].[LendStatus] ON 
GO
INSERT [dbo].[LendStatus] ([StatusId], [StatusName]) VALUES (1, N'在庫')
GO
INSERT [dbo].[LendStatus] ([StatusId], [StatusName]) VALUES (2, N'出借中')
GO
INSERT [dbo].[LendStatus] ([StatusId], [StatusName]) VALUES (3, N'整理中')
GO
INSERT [dbo].[LendStatus] ([StatusId], [StatusName]) VALUES (4, N'遺失')
GO
INSERT [dbo].[LendStatus] ([StatusId], [StatusName]) VALUES (5, N'毀損')
GO
INSERT [dbo].[LendStatus] ([StatusId], [StatusName]) VALUES (6, N'廢棄')
GO
SET IDENTITY_INSERT [dbo].[LendStatus] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 
GO
INSERT [dbo].[Users] ([UserId], [PhoneNumber], [Password], [UserName], [RegistrationTime], [LastLoginTime]) VALUES (1, N'0951111111', N'password1', N'User1', CAST(N'2023-09-01T10:00:00.000' AS DateTime), CAST(N'2023-10-10T15:00:00.000' AS DateTime))
GO
INSERT [dbo].[Users] ([UserId], [PhoneNumber], [Password], [UserName], [RegistrationTime], [LastLoginTime]) VALUES (2, N'0952222222', N'password2', N'User2', CAST(N'2023-09-02T11:00:00.000' AS DateTime), CAST(N'2023-10-11T14:30:00.000' AS DateTime))
GO
INSERT [dbo].[Users] ([UserId], [PhoneNumber], [Password], [UserName], [RegistrationTime], [LastLoginTime]) VALUES (3, N'0953333333', N'password3', N'User3', CAST(N'2023-09-03T12:00:00.000' AS DateTime), CAST(N'2023-10-12T13:45:00.000' AS DateTime))
GO
INSERT [dbo].[Users] ([UserId], [PhoneNumber], [Password], [UserName], [RegistrationTime], [LastLoginTime]) VALUES (4, N'0954444444', N'password4', N'User4', CAST(N'2023-09-04T13:00:00.000' AS DateTime), CAST(N'2023-10-13T12:15:00.000' AS DateTime))
GO
INSERT [dbo].[Users] ([UserId], [PhoneNumber], [Password], [UserName], [RegistrationTime], [LastLoginTime]) VALUES (5, N'0955555555', N'password5', N'User5', CAST(N'2023-09-05T14:00:00.000' AS DateTime), CAST(N'2023-10-14T11:30:00.000' AS DateTime))
GO
INSERT [dbo].[Users] ([UserId], [PhoneNumber], [Password], [UserName], [RegistrationTime], [LastLoginTime]) VALUES (6, N'0956666666', N'password6', N'User6', CAST(N'2023-09-06T15:00:00.000' AS DateTime), CAST(N'2023-10-15T10:45:00.000' AS DateTime))
GO
INSERT [dbo].[Users] ([UserId], [PhoneNumber], [Password], [UserName], [RegistrationTime], [LastLoginTime]) VALUES (7, N'0957777777', N'password7', N'User7', CAST(N'2023-09-07T16:00:00.000' AS DateTime), CAST(N'2023-10-16T09:30:00.000' AS DateTime))
GO
INSERT [dbo].[Users] ([UserId], [PhoneNumber], [Password], [UserName], [RegistrationTime], [LastLoginTime]) VALUES (8, N'0958888888', N'password8', N'User8', CAST(N'2023-09-08T17:00:00.000' AS DateTime), CAST(N'2023-10-17T08:15:00.000' AS DateTime))
GO
INSERT [dbo].[Users] ([UserId], [PhoneNumber], [Password], [UserName], [RegistrationTime], [LastLoginTime]) VALUES (9, N'0959999999', N'password9', N'User9', CAST(N'2023-09-09T18:00:00.000' AS DateTime), CAST(N'2023-10-18T07:00:00.000' AS DateTime))
GO
INSERT [dbo].[Users] ([UserId], [PhoneNumber], [Password], [UserName], [RegistrationTime], [LastLoginTime]) VALUES (10, N'0950000000', N'password10', N'User10', CAST(N'2023-09-10T19:00:00.000' AS DateTime), CAST(N'2023-10-19T06:15:00.000' AS DateTime))
GO
INSERT [dbo].[Users] ([UserId], [PhoneNumber], [Password], [UserName], [RegistrationTime], [LastLoginTime]) VALUES (12, N'0950000001', N'password11', N'User11', CAST(N'2023-10-13T09:48:38.120' AS DateTime), CAST(N'2023-10-19T06:15:00.000' AS DateTime))
GO
INSERT [dbo].[Users] ([UserId], [PhoneNumber], [Password], [UserName], [RegistrationTime], [LastLoginTime]) VALUES (13, N'0950000002', N'53D453B0C08B6B38AE91515DC88D25FBECDD1D6001F022419629DF844F8BA433', N'User11', CAST(N'2023-10-13T10:06:29.177' AS DateTime), CAST(N'2023-10-19T06:15:00.000' AS DateTime))
GO
INSERT [dbo].[Users] ([UserId], [PhoneNumber], [Password], [UserName], [RegistrationTime], [LastLoginTime]) VALUES (14, N'0921762759', N'707F5D7020989CA8EDA06F6985FF472CA986BCF508010036433DC2B937C77C5D', N'User11', CAST(N'2023-10-13T11:20:32.523' AS DateTime), CAST(N'2023-10-19T06:15:00.000' AS DateTime))
GO
INSERT [dbo].[Users] ([UserId], [PhoneNumber], [Password], [UserName], [RegistrationTime], [LastLoginTime]) VALUES (17, N'0921777777', N'84C45E72EBFF7042E000B2BFD67B22367B18DDCB723CE4C32F9F1B2064999E08', N'User11', CAST(N'2023-10-13T11:49:47.570' AS DateTime), CAST(N'2023-10-19T06:15:00.000' AS DateTime))
GO
INSERT [dbo].[Users] ([UserId], [PhoneNumber], [Password], [UserName], [RegistrationTime], [LastLoginTime]) VALUES (18, N'0978778777', N'69EB37A629F7E8CEBC72D6B4E005BBEECBDFC6471A14B12C6CD079102B708823', N'User11', CAST(N'2023-10-13T11:51:43.473' AS DateTime), CAST(N'2023-10-19T06:15:00.000' AS DateTime))
GO
INSERT [dbo].[Users] ([UserId], [PhoneNumber], [Password], [UserName], [RegistrationTime], [LastLoginTime]) VALUES (20, N'0978456444', N'2F75CB140F1D0B8CC9BEA50AB9A32B9E6EA3CA31BABFAB23D6F5F814767EF11F', N'User11', CAST(N'2023-10-13T12:01:49.917' AS DateTime), CAST(N'2023-10-19T06:15:00.000' AS DateTime))
GO
INSERT [dbo].[Users] ([UserId], [PhoneNumber], [Password], [UserName], [RegistrationTime], [LastLoginTime]) VALUES (23, N'0912345678', N'9A2D05F0EA0DAB24814EFEC8BF9A5B377AD77330623112EAEB8981AB8D13ECB2', N'User11', CAST(N'2023-10-13T12:48:39.550' AS DateTime), CAST(N'2023-10-19T06:15:00.000' AS DateTime))
GO
INSERT [dbo].[Users] ([UserId], [PhoneNumber], [Password], [UserName], [RegistrationTime], [LastLoginTime]) VALUES (24, N'0922222222', N'7E0E8DCA444EF9B5C2EA087CF040B59B820FC4363A9B03795E0D793513B15E62', N'User11', CAST(N'2023-10-13T12:51:43.097' AS DateTime), CAST(N'2023-10-13T19:50:07.293' AS DateTime))
GO
INSERT [dbo].[Users] ([UserId], [PhoneNumber], [Password], [UserName], [RegistrationTime], [LastLoginTime]) VALUES (26, N'          ', N'E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855', N'User11', CAST(N'2023-10-13T15:28:11.603' AS DateTime), CAST(N'2023-10-13T15:38:40.497' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
/****** Object:  Index [IX_BorrowingRecord_InventoryId]    Script Date: 2023/10/13 下午 11:40:05 ******/
ALTER TABLE [dbo].[BorrowingRecord] ADD  CONSTRAINT [IX_BorrowingRecord_InventoryId] UNIQUE NONCLUSTERED 
(
	[InventoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_BorrowingRecord_UserId]    Script Date: 2023/10/13 下午 11:40:05 ******/
CREATE NONCLUSTERED INDEX [IX_BorrowingRecord_UserId] ON [dbo].[BorrowingRecord]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_User_phone]    Script Date: 2023/10/13 下午 11:40:05 ******/
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [IX_User_phone] UNIQUE NONCLUSTERED 
(
	[PhoneNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
USE [master]
GO
ALTER DATABASE [LibraryLendingSystem] SET  READ_WRITE 
GO
