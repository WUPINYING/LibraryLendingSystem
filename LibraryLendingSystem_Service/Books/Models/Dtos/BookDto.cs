namespace LibraryLendingSystem_Service.Books.Models.Dtos
{
    public class BookDto
    {
        public string Isbn { get; set; }

        public string Name { get; set; }

        public string Author { get; set; }

        public string Introduction { get; set; }

        public string StatusName { get; set; }
    }
}
