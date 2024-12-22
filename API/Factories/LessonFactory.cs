using API.DTO.Teacher;
using API.Entities;


namespace API.Factories
{
    public class LessonFactory : IEntityFactory<Lesson>
    {
        public Lesson CreateEntity(object[] objects)
        {
            if (objects.Length != 3)
                throw new ArgumentException("Invalid number of parameters for LessonFactory.");

            var lessonDto = objects[0] as CreateLessonDto;
            var lessonid = objects[1] as string;
            var Qrcode = objects[2] as string;


            if (lessonDto == null || lessonid == null || Qrcode == null )
                throw new ArgumentException("Invalid parameters provided for LessonFactory.");
            
            return new Lesson
            {
                ID = lessonid,
                Title = lessonDto.Title,
                Description = lessonDto.Description,
                StartDateTime = lessonDto.StartTime,
                EndDateTime = lessonDto.StartTime.AddHours(2),
                GroupId = lessonDto.GroupId,
                IsAttendanceAllow = lessonDto.IsAttendanceAllow,
                QRCode = Qrcode
            };

        }
    }
}
