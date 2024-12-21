using System.ComponentModel.DataAnnotations;

namespace API.DTO.Student
{
    public class LogIn_Student_dto
    {
        [Required]
        public string Student_email { get; set; }
        [Required]
        public string Student_password { get; set; }
    }
}
