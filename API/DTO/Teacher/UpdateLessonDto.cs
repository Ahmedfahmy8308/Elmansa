using System.Drawing;

namespace API.DTO.Teacher
{
    public class UpdateLessonDto
    {
        public string Id { get; set; } = null!;
        public string Title { get; set; } = null!;
        public string Description { get; set; } = null!;
        public DateTime StartTime { get; set; }
        public DateTime EndTime { get; set; }
        public int GroupId { get; set; }
        public bool IsAttendanceAllow { get; set; }
    }
}
