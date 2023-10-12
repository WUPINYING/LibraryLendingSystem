using LibraryLendingSystem_Service.Users.Models.Dtos;

namespace LibraryLendingSystem_Service.Users.Interface
{
    public interface IUserDapperRepo
    {
        RegisterDto Register(RegisterDto dto);
    }
}
