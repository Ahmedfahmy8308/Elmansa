using System.ComponentModel.DataAnnotations;

namespace API.DTO.Teacher
{
    public class LogIn_Teacher_dto
    {
        [Required]
        public string Teacher_email { get; set; }
        [Required]
        public string Teacher_password { get; set; }
    }
}
