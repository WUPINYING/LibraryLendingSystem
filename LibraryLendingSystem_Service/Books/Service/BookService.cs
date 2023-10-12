using LibraryLendingSystem_Service.Books.Interface;
using LibraryLendingSystem_Service.Books.Models.Dtos;
using LibraryLendingSystem_Service.Models;

namespace LibraryLendingSystem_Service.Books.Service
{
    public class BookService
    {
        private IDapperRepo _repo;
        private AppDbContext _db;

        public BookService(IDapperRepo repo)
        {
            _repo = repo;
            _db = new AppDbContext();
        }

        public IEnumerable<BookDto> GetBooksList()
        {
            var result = _repo.GetBooksList();
            return result;
        }
    }
}
