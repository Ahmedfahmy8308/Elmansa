using API.Data;
using API.DTO.Student;
using API.Entities;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using API.Utilities;
using System;
using System.IO;
using System.Linq;
using System.Threading.Tasks;

namespace API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AccountController : ControllerBase
    {
        private readonly UserManager<AppUser> _userManager;
        private readonly SignInManager<AppUser> _signInManager;
        private readonly AppDbContext _Mydb;

        public AccountController(
            UserManager<AppUser> userManager,
            SignInManager<AppUser> signInManager,
            AppDbContext Mydb
        )
        {
            _userManager = userManager;
            _signInManager = signInManager;
            _Mydb = Mydb;
        }

        [HttpPost("Register")]
        public async Task<IActionResult> Register([FromForm] Register_dto register)
        {
            var allowedStudent = _Mydb.AllowedStudents.FirstOrDefault(x => x.Email == register.Student_email);
            if (allowedStudent == null || !allowedStudent.AccountActive)
                return BadRequest("You are not allowed to register.");

            if (await _userManager.FindByEmailAsync(register.Student_email) != null)
                return BadRequest("Email already exists.");

            var validationResult = Validator.ValidateStudentInfo(register);
            if (validationResult != null)
                return BadRequest(validationResult);


            var userid = IdGenerator.GenerateUniqueId();

            var filePaths = PathGenerator.GenerateStudentImagePath(register.Student_photo.FileName, userid);

            await FileHelper.SaveStudentPhoto(register.Student_photo, filePaths.AbsolutePath);

            var user = new AppUser
            {
                UserName = userid,
                Email = register.Student_email
            };

            var student = new Student
            {
                ID = userid,
                Fname = register.Student_first_name,
                Mname = register.Student_Middel_name,
                Lname = register.Student_last_name,
                Email = register.Student_email,
                DateOfBirth = register.Student_date_birth,
                Number = register.Student_number,
                SSN = register.Student_SSN,
                GuardianNumber = register.Student_guardian_number,
                Password = register.Student_password,
                PhotoPath = filePaths.RelativePath,
                Stage = allowedStudent.Stage,
                StageLevel = allowedStudent.StageLevel,
                GroupId = allowedStudent.GroupID
            };

            var result = await _userManager.CreateAsync(user, register.Student_password);
            if (!result.Succeeded)
                return BadRequest(result.Errors.Select(e => e.Description));

            _Mydb.Students.Add(student);
            await _Mydb.SaveChangesAsync();

            return Ok(new { message = "Registration successful", userId = user.Id, photoPath = student.PhotoPath });
        }
    }
}
