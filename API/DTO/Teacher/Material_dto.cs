namespace API.DTO.Teacher
{
    public class Material_dto
    {
        public string Material_id { get; set; } = null!;
        public string Material_title { get; set; } = null!;
        public string Material_type { get; set; } = null!;
        public IFormFile formFile { get; set; } = null!;
        public DateTime Material_upload_date { get; set; }

    }
}
