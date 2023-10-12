using LibraryLendingSystem_Service.Models;
using LibraryLendingSystem_Service.Users.Interface;
using LibraryLendingSystem_Service.Users.Models.Dtos;

namespace LibraryLendingSystem_Service.Users.Service
{
    public class UserService
    {
        private IUserDapperRepo _repo;
        private AppDbContext _db;

        public UserService(IUserDapperRepo repo)
        {
            _repo = repo;
            _db = new AppDbContext();
        }
        public RegisterDto Register(RegisterDto dto)
        {
            var result = _repo.Register(dto);
            return result;
        }
    }
}
