using API.Data;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace API.Controllers.Student
{
    [Route("api/[controller]")]
    [ApiController]
    public class StudentAccount : ControllerBase
    {
        readonly AppDbContext _mydb;
        public StudentAccount(AppDbContext mydb)
        {
            _mydb = mydb;
        }


    }
}
