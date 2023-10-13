using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using LibraryLendingSystem_Service.Models;
using Microsoft.AspNetCore.Cors;
using LibraryLendingSystem_Service.Members.Interface;
using LibraryLendingSystem_Service.Members.Models.Dtos;
using LibraryLendingSystem_Service.Members.Service;
using LibraryLendingSystem_Service.Infa;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authentication;
using Newtonsoft.Json;
using System.Security.Claims;

namespace LibraryLendingSystem_Service.Controllers
{
    [EnableCors("AllowAny")]
    [Route("api/[controller]")]
    [ApiController]
    public class MembersController : ControllerBase
    {
        private readonly AppDbContext _db;
        private readonly IMemberDapperRepo _repo;

        public MembersController(AppDbContext db, IMemberDapperRepo repo)
        {
            _db = db;
            _repo = repo;
        }

        // GET: api/Users
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Users>>> GetUsers()
        {
            if (_db.Users == null)
            {
                return NotFound();
            }
            return await _db.Users.ToListAsync();
        }

        // GET: api/Users/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Users>> GetUsers(int id)
        {
            if (_db.Users == null)
            {
                return NotFound();
            }
            var users = await _db.Users.FindAsync(id);

            if (users == null)
            {
                return NotFound();
            }

            return users;
        }

        // PUT: api/Users/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutUsers(int id, Users users)
        {
            if (id != users.UserId)
            {
                return BadRequest();
            }

            _db.Entry(users).State = EntityState.Modified;

            try
            {
                await _db.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!UsersExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }

        // POST: api/Users
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost("Register")]
        public async Task<ActionResult<RegisterDto>> Register([FromBody] RegisterDto dto)
        {
            string phoneNumber = dto.PhoneNumber;
            bool hasUser = PhoneNumberExists(phoneNumber);

            //是否跟資料庫的手機號碼有重複
            if (hasUser == false)
            {
                //是，返回輸入的資料
                return BadRequest();
            }
            else
            {
                //否，帳號密碼存入資料庫
                string salt = HashUtility.GetSalt();
                dto.Password = HashUtility.ToSHA256(dto.Password, salt);

                var service = new MemberService(_repo);
                var result = service.Register(dto);
                return Ok(result);
            }
        }

        [HttpPost("Login")]
        public async Task<IActionResult> Login([FromBody] RegisterDto dto)
        {
            string phoneNumber = dto.PhoneNumber;
            bool hasUser = PhoneNumberExists(phoneNumber);

            if (hasUser == true)
            {
                return BadRequest("找不到會員紀錄");
            }
            else
            {
                string salt = HashUtility.GetSalt();
                var userEnterPwd = HashUtility.ToSHA256(dto.Password, salt);

                var userData = (from m in _db.Users
                                where m.PhoneNumber == dto.PhoneNumber
                                select m).SingleOrDefault();

                var userPwdInDb = userData.Password;

                if (userEnterPwd == userPwdInDb)
                {
                    dto.Password = userPwdInDb;
                    var service = new MemberService(_repo);

                    var claims = new List<Claim>
            {
                new Claim(ClaimTypes.Name, userData.PhoneNumber),
                new Claim("MemberId", userData.UserId.ToString())
            };

                    var claimsIdentity = new ClaimsIdentity(claims, CookieAuthenticationDefaults.AuthenticationScheme);
                    var authProperties = new AuthenticationProperties
                    {
                        IsPersistent = true,
                        ExpiresUtc = DateTime.UtcNow.AddDays(7),
                    };

                    // 控制登入狀態
                    HttpContext.SignInAsync(CookieAuthenticationDefaults.AuthenticationScheme, new ClaimsPrincipal(claimsIdentity));


                    service.Login(dto);
                    return Ok("會員登入成功");
                }
                else
                {
                    return BadRequest("會員登入失敗");
                }
            }

        }


        // DELETE: api/Users/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteUsers(int id)
        {
            if (_db.Users == null)
            {
                return NotFound();
            }
            var users = await _db.Users.FindAsync(id);
            if (users == null)
            {
                return NotFound();
            }

            _db.Users.Remove(users);
            await _db.SaveChangesAsync();

            return NoContent();
        }

        private bool UsersExists(int id)
        {
            return (_db.Users?.Any(e => e.UserId == id)).GetValueOrDefault();
        }

        private bool PhoneNumberExists(string phoneNum)
        {
            var userInDb = _db.Users.FirstOrDefault(u => u.PhoneNumber == phoneNum);
            if (userInDb == null) return true;
            return false;
        }

    }
}
