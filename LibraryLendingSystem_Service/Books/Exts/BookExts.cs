using LibraryLendingSystem_Service.Books.Models.Dtos;
using LibraryLendingSystem_Service.Books.Models.Vms;

namespace LibraryLendingSystem_Service.Books.Exts
{
    public static class BookExts
    {
        public static BookVm ToBooVM(this BookDto dto)
        {
            return new BookVm
            {
                Isbn = dto.Isbn,
                Name = dto.Name,
                Author = dto.Author,
                Introduction = dto.Introduction,
                StatusName = dto.StatusName
            };
        }
    }
}
