using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using LibraryLendingSystem_Service.Models;
using Microsoft.AspNetCore.Cors;
using LibraryLendingSystem_Service.Members.Interface;
using LibraryLendingSystem_Service.Members.Models.Dtos;
using LibraryLendingSystem_Service.Members.Service;
using LibraryLendingSystem_Service.Infa;

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
            var userInDb = _db.Users.FirstOrDefault(p => p.PhoneNumber == phoneNum);
            if (userInDb == null) return true;
            return false;
        }

    }
}
