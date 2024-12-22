namespace API.DTO.Teacher
{
    public class CreateLessonDto
    {
        public string Title { get; set; } = null!;
        public string Description { get; set; } = null!;
        public DateTime StartTime { get; set; }
        public int GroupId { get; set; }
        public bool IsAttendanceAllow { get; set; }
    }
}
