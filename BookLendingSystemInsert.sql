--User
INSERT INTO [User] ([PhoneNumber], [Password], [UserName], [RegistrationTime], [LastLoginTime])
VALUES
('0951111111', 'password1', 'User1', '2023-09-01 10:00:00', '2023-10-10 15:00:00'),
('0952222222', 'password2', 'User2', '2023-09-02 11:00:00', '2023-10-11 14:30:00'),
('0953333333', 'password3', 'User3', '2023-09-03 12:00:00', '2023-10-12 13:45:00'),
('0954444444', 'password4', 'User4', '2023-09-04 13:00:00', '2023-10-13 12:15:00'),
('0955555555', 'password5', 'User5', '2023-09-05 14:00:00', '2023-10-14 11:30:00'),
('0956666666', 'password6', 'User6', '2023-09-06 15:00:00', '2023-10-15 10:45:00'),
('0957777777', 'password7', 'User7', '2023-09-07 16:00:00', '2023-10-16 09:30:00'),
('0958888888', 'password8', 'User8', '2023-09-08 17:00:00', '2023-10-17 08:15:00'),
('0959999999', 'password9', 'User9', '2023-09-09 18:00:00', '2023-10-18 07:00:00'),
('0950000000', 'password10', 'User10', '2023-09-10 19:00:00', '2023-10-19 06:15:00');

--Status
INSERT INTO LendStatus (StatusName)
VALUES
('在庫'),
('出借中'),
('整理中'),
('遺失'),
('毀損'),
('廢棄');

--Inventory
INSERT INTO [Inventory] ([ISBN], [StoreTime],[Status_Id])
VALUES
('9780451169510', '2023-09-20', '1'),
('9780307588364', '2023-09-20', '2'),
('9780061120084', '2023-09-20', '3'),
('9780743273565', '2023-09-20', '4'),
('9780060850524', '2023-09-20', '5'),
('9780062075807', '2023-09-20', '6'),
('9780544003415', '2023-09-20', '1'),
('9780141439563', '2023-09-20', '1'),
('9780743273565', '2023-09-20', '1'),
('9780743273565', '2023-09-20', '1');

--BorrowingRecord
INSERT INTO [BorrowingRecord] ([UserId], [InventoryId], [BorrowingTime], [ReturnTime])
VALUES
(1, 3, '2023-10-01 10:00:00', '2023-10-10 15:00:00'),
(1, 2, '2023-10-02 11:00:00', '2023-10-11 14:30:00'),
(3, 1, '2023-10-03 12:00:00', '2023-10-12 13:45:00'),
(3, 9, '2023-10-04 13:00:00', '2023-10-13 12:15:00'),
(7, 7, '2023-10-05 14:00:00', '2023-10-14 11:30:00'),
(6, 6, '2023-10-06 15:00:00', '2023-10-15 10:45:00'),
(7, 8, '2023-10-07 16:00:00', '2023-10-16 09:30:00'),


--Book
INSERT INTO [Book] ([ISBN], [Name], [Author], [Introduction])
VALUES
('9780451169510', 'To Kill a Mockingbird', 'Harper Lee', 'A classic novel set in the American South.'),
('9780307588364', 'The Great Gatsby', 'F. Scott Fitzgerald', 'The story of Jay Gatsby and the Roaring Twenties.'),
('9780061120084', 'To Kill a Mockingbird', 'George Orwell', 'A dystopian novel about surveillance and control.'),
('9780743273565', 'The Catcher in the Rye', 'J.D. Salinger', 'The coming-of-age story of Holden Caulfield.'),
('9780060850524', 'Pride and Prejudice', 'Jane Austen', 'A classic romance novel.'),
('9780062075807', '1984', 'George Orwell', 'A dystopian novel about a totalitarian regime.'),
('9780544003415', 'The Hobbit', 'J.R.R. Tolkien', 'The adventures of Bilbo Baggins.'),
('9780141439563', 'Frankenstein', 'Mary Shelley', 'A tale of scientific experimentation and the consequences.'),
('9780743273500', 'The Catcher in the Rye', 'J.D. Salinger', 'The coming-of-age story of Holden Caulfield.'),
('9780743273511', 'The Catcher in the Rye', 'J.D. Salinger', 'The coming-of-age story of Holden Caulfield.');


--SELECTE
SELECT * FROM [User];
SELECT * FROM LendStatus;
SELECT * FROM Inventory;
SELECT * FROM BorrowingRecord;
SELECT * FROM Book;


SELECT Book.[ISBN],[Name],[Author],[Introduction],[StatusName]
FROM Book
JOIN Inventory
ON Book.ISBN=Inventory.ISBN
JOIN LendStatus
ON Inventory.Status_Id=LendStatus.StatusId;


--INSERT
INSERT INTO [BorrowingRecord] ([UserId], [InventoryId], [BorrowingTime], [ReturnTime])
VALUES (8, 8, GETDATE(), DATEADD(MONTH, 1, GETDATE()));

INSERT INTO [User]
VALUES ('0912123123','password11','User11',GETDATE(),'2023-10-19 06:15:00');
