using API.Entities;

namespace API.DTO.Teacher
{
    public class Group_Add_dto
    {
        public string Group_name { get; set; } = null!;

        public string Groub_stage { get; set; } = null!;

        public int Group_stage_level { get; set; }

        public DateTime Group_created_data { get; set; }

        public bool Group_active { get; set; }
    }
}
