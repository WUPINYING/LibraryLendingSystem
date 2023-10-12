using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using LibraryLendingSystem_Service.Models;
using Microsoft.AspNetCore.Cors;
using LibraryLendingSystem_Service.Books.Service;
using LibraryLendingSystem_Service.Books.Interface;
using LibraryLendingSystem_Service.Books.Exts;
using LibraryLendingSystem_Service.Books.Models.Dtos;

namespace LibraryLendingSystem_Service.Controllers
{
    [EnableCors("AllowAny")]
    [Route("api/[controller]")]
    [ApiController]
    public class BooksController : ControllerBase
    {
        private readonly AppDbContext _db;
        private IDapperRepo _repo;

        public BooksController(AppDbContext db, IDapperRepo repo)
        {
            _db = db;
            _repo = repo;
        }

        // GET: api/Books
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Book>>> GetBook()
        {
            var service = new BookService(_repo);
            var book = service.GetBooksList().Select(b => b.ToBooVM());
            return Ok(book);
            //if (_context.Book == null)
            //{
            //    return null;
            //}
            //  return await _context.Book.ToListAsync();
        }

        // GET: api/Books/5
        [HttpGet("{id}")]
        public async Task<Book> GetBook(string id)
        {
            if (_db.Book == null)
            {
                return null;
            }
            var book = await _db.Book.FindAsync(id);

            if (book == null)
            {
                return null;
            }

            return book;
        }

        // PUT: api/Books/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutBook(string id, Book book)
        {
            if (id != book.Isbn)
            {
                return BadRequest();
            }

            _db.Entry(book).State = EntityState.Modified;

            try
            {
                await _db.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!BookExists(id))
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

        // POST: api/Books
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<Book>> PostBook(Book book)
        {
            if (_db.Book == null)
            {
                return Problem("Entity set 'AppDbContext.Book'  is null.");
            }
            _db.Book.Add(book);
            try
            {
                await _db.SaveChangesAsync();
            }
            catch (DbUpdateException)
            {
                if (BookExists(book.Isbn))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtAction("GetBook", new { id = book.Isbn }, book);
        }


        [HttpPost("BorrowBook")]
        public async Task<ActionResult<BorrowBookDto>> BorrowBook(BorrowBookDto dto)
        {
            //是否登入
            //如果無法取得使用者資訊
            //就請登入
            //不然就存使用者資訊
            //丟給service
            var service = new BookService(_repo);
            var result = service.BorrowBook(dto);
            return Ok(result);
        }

        // DELETE: api/Books/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteBook(string id)
        {
            if (_db.Book == null)
            {
                return NotFound();
            }
            var book = await _db.Book.FindAsync(id);
            if (book == null)
            {
                return NotFound();
            }

            _db.Book.Remove(book);
            await _db.SaveChangesAsync();

            return NoContent();
        }

        private bool BookExists(string id)
        {
            return (_db.Book?.Any(e => e.Isbn == id)).GetValueOrDefault();
        }
    }
}
