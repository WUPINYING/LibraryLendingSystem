--User
INSERT INTO [Users] ([PhoneNumber], [Password], [UserName], [RegistrationTime], [LastLoginTime])
VALUES
('0951111111', '53D453B0C08B6B38AE91515DC88D25FBECDD1D6001F022419629DF844F8BA433', 'User1', '2023-09-01 10:00:00', '2023-10-10 15:00:00'),
('0952222222', '707F5D7020989CA8EDA06F6985FF472CA986BCF508010036433DC2B937C77C5D', 'User2', '2023-09-02 11:00:00', '2023-10-11 14:30:00'),
('0953333333', '84C45E72EBFF7042E000B2BFD67B22367B18DDCB723CE4C32F9F1B2064999E08', 'User3', '2023-09-03 12:00:00', '2023-10-12 13:45:00'),
('0954444444', '69EB37A629F7E8CEBC72D6B4E005BBEECBDFC6471A14B12C6CD079102B708823', 'User4', '2023-09-04 13:00:00', '2023-10-13 12:15:00'),
('0955555555', '2F75CB140F1D0B8CC9BEA50AB9A32B9E6EA3CA31BABFAB23D6F5F814767EF11F', 'User5', '2023-09-05 14:00:00', '2023-10-14 11:30:00'),
('0956666666', '9A2D05F0EA0DAB24814EFEC8BF9A5B377AD77330623112EAEB8981AB8D13ECB2', 'User6', '2023-09-06 15:00:00', '2023-10-15 10:45:00'),
('0922222222', '7E0E8DCA444EF9B5C2EA087CF040B59B820FC4363A9B03795E0D793513B15E62', 'User7', '2023-09-07 16:00:00', '2023-10-16 09:30:00');


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
(7, 8, '2023-10-07 16:00:00', '2023-10-16 09:30:00');


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
SELECT * FROM Users;
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

INSERT INTO [Users]
VALUES ('0912123123','password11','User11',GETDATE(),'2023-10-19 06:15:00');


--UPDATE
UPDATE [Users]
SET LastLoginTime = GETDATE()
WHERE PhoneNumber = '0922222222';