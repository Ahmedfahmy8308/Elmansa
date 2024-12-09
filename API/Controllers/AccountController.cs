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
            // Check if the student is allowed to register
            var allowedStudent = _Mydb.AllowedStudents.FirstOrDefault(x => x.Email == register.Student_email);

            if (allowedStudent == null || !allowedStudent.AccountActive)
                return BadRequest("You are not allowed to register.");

            // Check if the email already exists
            if (await _userManager.FindByEmailAsync(register.Student_email) != null)
                return BadRequest("Email already exists.");

            // Validate phone numbers and SSN
            var validationResult = ValidateStudentInfo(register);
            if (validationResult != null)
                return BadRequest(validationResult);

            // Handle student photo
            if (register.Student_photo == null || register.Student_photo.Length == 0)
                return BadRequest("Please upload a valid photo.");

            // Generate a unique user ID
            var userid = IdGenerator.GenerateUniqueId();

            // Generate file path for storing the photo
            var filePaths = PathGenerator.GenerateStudentImagePath(register.Student_photo.FileName, userid);

            // Save the student's photo to disk
            await SaveStudentPhoto(register.Student_photo, filePaths.AbsolutePath);

            // Create a new AppUser
            var user = new AppUser
            {
                UserName = userid,
                Email = register.Student_email
            };

            // Create the student entity
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

            // Create user in Identity system
            var result = await _userManager.CreateAsync(user, register.Student_password);

            if (!result.Succeeded)
                return BadRequest(result.Errors.Select(e => e.Description));

            // Save student data to the database
            _Mydb.Students.Add(student);
            await _Mydb.SaveChangesAsync();

            // Return a successful registration response
            return Ok(new { message = "Registration successful", userId = user.Id, photoPath = student.PhotoPath });
        }

        

       
    }
}
