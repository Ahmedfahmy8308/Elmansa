namespace API.DTO.Teacher
{
    public class Material_U_dto
    {
        public string Material_id { get; set; } = null!;
        public string Material_title { get; set; } = null!;
        public string Material_type { get; set; } = null!;
        public IFormFile File { get; set; } = null!;


    }
}
