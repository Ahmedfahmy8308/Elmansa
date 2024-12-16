using API.Data;
using API.DTO.Teacher;
using API.Entities;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace API.Controllers.TeacherControllers
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
        public async Task<IActionResult> Get()
        {
            var Opj = await _mydb.AllowedStudents.ToListAsync();
            var AllowedStudents = new List<AllowedStudent_dto>();

            foreach (var item in Opj)
            {
                AllowedStudent_dto allowedStudent = new AllowedStudent_dto();
                
                allowedStudent.AllowedStudent_email = item.Email;
                allowedStudent.AllowedStudent_stage = item.Stage;
                allowedStudent.AllowedStudent_stage_level = item.StageLevel;
                allowedStudent.AllowedStudent_group_id = item.GroupID;
                allowedStudent.AllowedStudent_account_active = item.AccountActive;

                AllowedStudents.Add(allowedStudent);
            }
            return Ok(AllowedStudents);
        }

        [HttpPost]
        public async Task<IActionResult> Post(AllowedStudent_dto allowedStudent)
        {
            var g = await _mydb.Groups.FirstOrDefaultAsync(x => x.ID == allowedStudent.AllowedStudent_group_id);
            if (g == null)
            {
                return BadRequest("Group not found");
            }
            if (allowedStudent.AllowedStudent_stage != g.Stage || 
                allowedStudent.AllowedStudent_stage_level!= g.StageLevel)
            {
                return BadRequest("Group stage and stage level not match with Group id");
            }

            AllowedStudent Opj = new AllowedStudent();
            Opj.Email = allowedStudent.AllowedStudent_email;
            Opj.Stage = allowedStudent.AllowedStudent_stage;
            Opj.StageLevel = allowedStudent.AllowedStudent_stage_level;
            Opj.GroupID = allowedStudent.AllowedStudent_group_id;
            Opj.AccountActive = allowedStudent.AllowedStudent_account_active;

            await _mydb.AllowedStudents.AddAsync(Opj);
            await _mydb.SaveChangesAsync();
            return Ok(allowedStudent);
        }

        [HttpDelete]
        public async Task<IActionResult> Delete(AllowedStudent_dto allowedStudent)
        {
            var Opj = await _mydb.AllowedStudents.FirstOrDefaultAsync(x => x.Email == allowedStudent.AllowedStudent_email);
            if (Opj == null)
            {
                return NotFound("No Such AllowedStudent ");
            }
            _mydb.AllowedStudents.Remove(Opj);
            await _mydb.SaveChangesAsync();
            return Ok();
        }

        [HttpPut]
        public async Task<IActionResult> Put(AllowedStudent_dto allowedStudent)
        {
            var g = await _mydb.Groups.FirstOrDefaultAsync(x => x.ID == allowedStudent.AllowedStudent_group_id);
            var Opj = await _mydb.AllowedStudents.FirstOrDefaultAsync(x => x.Email == allowedStudent.AllowedStudent_email);
            if (Opj == null)
            {
                return NotFound("No Such AllowedStudent");
            }
            if (g == null)
            {
                return BadRequest("Group not found");
            }
            if (allowedStudent.AllowedStudent_stage != g.Stage ||
                allowedStudent.AllowedStudent_stage_level != g.StageLevel)
            {
                return BadRequest("Group stage and stage level not match with Group id");
            }
            Opj.Stage = allowedStudent.AllowedStudent_stage;
            Opj.StageLevel = allowedStudent.AllowedStudent_stage_level;
            Opj.GroupID = allowedStudent.AllowedStudent_group_id;
            Opj.AccountActive = allowedStudent.AllowedStudent_account_active;
            await _mydb.SaveChangesAsync();
            return Ok(allowedStudent);
        }


    }
}
