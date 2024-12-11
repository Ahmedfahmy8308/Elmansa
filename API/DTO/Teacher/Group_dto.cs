using API.Entities;

namespace API.DTO.Teacher
{
    public class Group_dto
    {
        public int Group_id { get; set; }
        public string Group_name { get; set; } = null!;

        public string Groub_stage { get; set; } = null!;

        public int Group_stage_level { get; set; }

        public DateTime Group_created_data { get; set; }

        public bool Group_active { get; set; }
    }
}
