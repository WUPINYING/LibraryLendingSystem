using LibraryLendingSystem_Service.Members.Models.Dtos;
namespace LibraryLendingSystem_Service.Members.Interface
{
    public interface IMemberDapperRepo
    {
        RegisterDto Register(RegisterDto dto);

        void Login(RegisterDto dto);
    }
}