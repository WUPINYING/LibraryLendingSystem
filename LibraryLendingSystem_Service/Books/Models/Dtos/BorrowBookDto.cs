namespace LibraryLendingSystem_Service.Books.Models.Dtos
{
    public class BorrowBookDto
    {
        public int UserId { get; set; }

        public int InventoryId { get; set; }

        public DateTime BorrowingTime { get; set; }

        public DateTime ReturnTime { get; set; }
    }
}
