namespace API.DTO.Teacher
{
    public class AllowedStudent_dto
    {

        public string AllowedStudent_email { get; set; } = null!;
        public string AllowedStudent_stage { get; set; } = null!;
        public int AllowedStudent_stage_level { get; set; }
        public int? AllowedStudent_group_id { get; set; }
        public bool AllowedStudent_account_active { get; set; } = true;

    }
}
