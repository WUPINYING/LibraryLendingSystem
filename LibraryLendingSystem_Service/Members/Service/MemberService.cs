using LibraryLendingSystem_Service.Models;
using LibraryLendingSystem_Service.Members.Interface;
using LibraryLendingSystem_Service.Members.Models.Dtos;

namespace LibraryLendingSystem_Service.Members.Service
{
    public class MemberService
    {
        private IMemberDapperRepo _repo;
        private AppDbContext _db;

        public MemberService(IMemberDapperRepo repo)
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
