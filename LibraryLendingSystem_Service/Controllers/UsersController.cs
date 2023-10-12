using LibraryLendingSystem_Service.Models;
using LibraryLendingSystem_Service.Users.Interface;
using LibraryLendingSystem_Service.Users.Models.Dtos;
using LibraryLendingSystem_Service.Users.Service;
using Microsoft.AspNetCore.Cors;
using Microsoft.AspNetCore.Mvc;

namespace LibraryLendingSystem_Service.Controllers
{
    [EnableCors("AllowAny")]
    [Route("api/[controller]")]
    [ApiController]
    public class UsersController : ControllerBase
    {
        private readonly AppDbContext _db;
        private IUserDapperRepo _repo;

        public UsersController(AppDbContext db, IUserDapperRepo repo)
        {
            _db = db;
            _repo = repo;
        }
        [HttpPost("Register")]
        public async Task<ActionResult<RegisterDto>> Register([FromBody] RegisterDto dto)
        {
            var phoneNumber = dto.PhoneNumber;
            var hasUser = PhoneNumberExists(phoneNumber);

            //是否跟資料庫的手機號碼有重複
            if (hasUser != null)
            {
                //是，返回輸入的資料
                return dto;
            }
            else
            {
                //否，存入資料庫
                var service = new UserService(_repo);
                var result = service.Register(dto);
                return Ok(result);
            }
        }

        public bool PhoneNumberExists(string phoneNum)
        {
            var userInDb = _db.User.FirstOrDefault(p => p.PhoneNumber == phoneNum);
            return userInDb != null;
        }
    }
}
