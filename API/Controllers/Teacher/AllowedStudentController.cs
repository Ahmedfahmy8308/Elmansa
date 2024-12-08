using API.Data;
using API.Entities;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace API.Controllers.Teacher
{
    [Route("api/[controller]")]
    [ApiController]
    public class AllowedStudentController : ControllerBase
    {

        readonly AppDbContext _mydb;
        public AllowedStudentController(AppDbContext mydb)
        {
            _mydb = mydb;
        }

        [HttpGet]
        public async Task<List<AllowedStudent>> Get()
        {
            var AllowedStudents = await _mydb.AllowedStudents.ToListAsync();

            return AllowedStudents;
        }

    }
}
