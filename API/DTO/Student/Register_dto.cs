namespace API.DTO.Student
{
    public class Register_dto
    {
        public string Student_email { get; set; }
        public string Student_password { get; set; }
        public string Student_first_name { get; set; }
        public string Student_Middel_name { get; set; }
        public string Student_last_name { get; set; }
        public string Student_number { get; set; }
        public string Student_SSN { get; set; }
        public DateTime Student_date_birth { get; set; }
        public IFormFile Student_photo { get; set; }
        public string Student_guardian_number { get; set; }
    }
}
