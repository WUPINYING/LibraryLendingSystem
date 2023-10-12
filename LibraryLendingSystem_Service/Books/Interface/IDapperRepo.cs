using LibraryLendingSystem_Service.Books.Models.Dtos;

namespace LibraryLendingSystem_Service.Books.Interface
{
    public interface IDapperRepo
    {
        IEnumerable<BookDto> GetBooksList();
    }
}
