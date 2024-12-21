using API.Data;
using API.DTO.Teacher;
using API.Entities;
using API.UOW;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace API.Controllers.TeacherControllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AllowedStudentController : ControllerBase
    {

        private readonly IUnitOfWork _unitOfWork;
        public AllowedStudentController(IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;
        }

        [HttpGet]
        public async Task<IActionResult> Get()
        {
            var Opj = await _unitOfWork.AllowedStudents.GetAllAsync();
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

        [HttpGet]
        [Route("{email}")]
        public async Task<IActionResult> Get(string email)
        {
            var Opj = await _unitOfWork.AllowedStudents.GetByIdAsync(email);
            if (Opj == null)
            {
                return NotFound("No Such AllowedStudent");
            }
            AllowedStudent_dto allowedStudent = new AllowedStudent_dto();
            allowedStudent.AllowedStudent_email = Opj.Email;
            allowedStudent.AllowedStudent_stage = Opj.Stage;
            allowedStudent.AllowedStudent_stage_level = Opj.StageLevel;
            allowedStudent.AllowedStudent_group_id = Opj.GroupID;
            allowedStudent.AllowedStudent_account_active = Opj.AccountActive;
            return Ok(allowedStudent);
        }
        [HttpPost]
        public async Task<IActionResult> Post(AllowedStudent_dto allowedStudent)
        {
            var g = await _unitOfWork.Groups.GetByIdAsync(allowedStudent.AllowedStudent_group_id);
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

            await _unitOfWork.AllowedStudents.AddAsync(Opj);
            await _unitOfWork.CompleteAsync();
            return Ok(allowedStudent);
        }

        [HttpDelete]
        public async Task<IActionResult> Delete(AllowedStudent_dto allowedStudent)
        {
            var Opj = await _unitOfWork.AllowedStudents.GetByIdAsync(allowedStudent.AllowedStudent_email);
            if (Opj == null)
            {
                return NotFound("No Such AllowedStudent ");
            }
            _unitOfWork.AllowedStudents.Delete(Opj);
            await _unitOfWork.CompleteAsync();

            return Ok();
        }

        [HttpPut]
        public async Task<IActionResult> Put(AllowedStudent_dto allowedStudent)
        {
            var g = await _unitOfWork.Groups.GetByIdAsync(allowedStudent.AllowedStudent_group_id);
            var Opj = await _unitOfWork.AllowedStudents.GetByIdAsync(allowedStudent.AllowedStudent_email);
            if (Opj == null)
            {
                return NotFound("No Such Allowed Student");
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
            _unitOfWork.AllowedStudents.Update(Opj);
            await _unitOfWork.CompleteAsync();
            return Ok(allowedStudent);
        }


    }
}
