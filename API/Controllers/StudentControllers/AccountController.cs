using API.DTO.Student;
using API.Data;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using API.Utilities;
using API.UOW;
using API.Entities;
using System.Security.Claims;
using System.IdentityModel.Tokens.Jwt;
using Microsoft.IdentityModel.Tokens;
using System.Text;

namespace API.Controllers.StudentControllers
{
    [Route("api/Student/[controller]")]
    [ApiController]
    public class AccountController : ControllerBase
    {
        private readonly UserManager<AppUser> _userManager;
        private readonly SignInManager<AppUser> _signInManager;
        private readonly IUnitOfWork _unitOfWork;
        private readonly IConfiguration _config;

        private FileHelper FileHelper = FileHelper.Instance;
        public AccountController(
            UserManager<AppUser> userManager,
            SignInManager<AppUser> signInManager,
            IUnitOfWork unitOfWork,
            IConfiguration config
        )
        {
            _userManager = userManager;
            _signInManager = signInManager;
            _unitOfWork = unitOfWork;
            _config = config;
        }

        [HttpPost("Register")]
        public async Task<IActionResult> Register([FromForm] Register_dto register)
        {
            var allowedStudent = _unitOfWork.AllowedStudents.GetByIdAsync(register.Student_email).Result;

            if (_unitOfWork.Students.IsSsnExit(register.Student_SSN))
                return BadRequest("SSN already exists");

            if (!_unitOfWork.Students.IsStudentAllowed(register.Student_email))
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

            var StudentFactory = FactoryProvider.GetFactory<Student>();
            var student = StudentFactory.CreateEntity(new object[] { register, allowedStudent, filePaths.RelativePath, userid });


            _unitOfWork.Students.AddAsync(student);

            var result = await _userManager.CreateAsync(user, register.Student_password);

            if (!result.Succeeded)
                return BadRequest(result.Errors.Select(e => e.Description));

            var roleResult = await _userManager.AddToRoleAsync(user, "Student");

            if (!roleResult.Succeeded)
                return BadRequest(roleResult.Errors.Select(e => e.Description));

            _unitOfWork.CompleteAsync();

            return Ok(new { message = "Registration successful", userId = user.Id });
        }


        [HttpPost("LogIn")]
        public async Task<IActionResult> LogIn([FromBody] LogIn_dto login)
        {
            var user = await _userManager.FindByEmailAsync(login.Student_email);

            if (user == null)
                return BadRequest("Invalid email or password");
            else
            {
                var result = await _signInManager.CheckPasswordSignInAsync(user, login.Student_password, false);
                if (!result.Succeeded)
                    return BadRequest("Invalid email or password");
                else
                {
                    var claims = new List<Claim>
                    {
                        new Claim(ClaimTypes.NameIdentifier, user.Id),
                        new Claim(ClaimTypes.Email, user.Email),
                        new Claim(JwtRegisteredClaimNames.Jti , IdGenerator.GenerateUniqueId())

                    };
                    var roles = await _userManager.GetRolesAsync(user);
                    foreach (var role in roles)
                    {
                        claims.Add(new Claim(ClaimTypes.Role, role));
                    }

                    var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_config["Jwt:Key"]));
                    var SC = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);
                    var token = new JwtSecurityToken(
                        claims: claims,
                        issuer: _config["Jwt:Issuer"],
                        audience: _config["Jwt:Audience"],
                        expires: DateTime.Now.AddMinutes(30),
                        signingCredentials: SC
                    );

                    var tokenString = new
                    {
                        token = new JwtSecurityTokenHandler().WriteToken(token),
                        Exception = token.ValidTo
                    };

                    return Ok(tokenString);


                }
            }


        }


    }
}
