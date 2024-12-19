using API.Data;
using API.DTO.Teacher;
using API.Utilities;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

namespace API.Controllers.TeacherControllers
{
    [Route("api/Teacher/[controller]")]
    [ApiController]
    public class AccountController : ControllerBase
    {

        private readonly UserManager<AppUser> _userManager;
        private readonly SignInManager<AppUser> _signInManager;
        private readonly IConfiguration _config;
        public AccountController(UserManager<AppUser> userManager, SignInManager<AppUser> signInManager, IConfiguration configuration)
        {
            _userManager = userManager;
            _signInManager = signInManager;
            _config = configuration;
        }

        [HttpPost("LogIn")]
        public async Task<IActionResult> LogIn([FromBody] LogIn_Teacher_dto login)
        {
            var user = await _userManager.FindByEmailAsync(login.Teacher_email);

            if (user == null)
                return BadRequest("Invalid email or password");

            var result = await _signInManager.CheckPasswordSignInAsync(user, login.Teacher_password, false);
            if (!result.Succeeded)
                return BadRequest("Invalid email or password");

            var claims = new List<Claim>
                {
                    new Claim(ClaimTypes.NameIdentifier, user.Id),
                    new Claim(ClaimTypes.Email, user.Email),
                    new Claim(JwtRegisteredClaimNames.Jti , IdGenerator.GenerateUniqueId())
                };

            var roles = await _userManager.GetRolesAsync(user);

            if (roles.Contains("Teacher"))
            {
                claims.Add(new Claim(ClaimTypes.Role, "Teacher"));
            }
            else
            {
                return Unauthorized("User role is not allowed.");
            }

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
                Exception = token.ValidTo,
                Role = roles.FirstOrDefault() 
            };

            return Ok(tokenString);
        }

    }
}

