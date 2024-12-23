using API.DTO.Teacher;
using API.Entities;
using API.UOW;
using API.Utilities;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using QRCoder;

namespace API.Controllers.TeacherControllers
{
    [Route("api/[controller]")]
    //[Authorize(Roles = "Teacher")]
    [ApiController]
    public class LessonController : ControllerBase
    {
        readonly IUnitOfWork _unitOfWork;
        public LessonController(IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;
        }



        [HttpPost]
        public async Task<IActionResult> CreateLesson([FromBody] CreateLessonDto dto)
        {
            if (!ModelState.IsValid)
                return BadRequest(ModelState);

            try
            {
                var group = await _unitOfWork.Groups.GetByIdAsync(dto.GroupId);
                if (group == null)
                    return NotFound(new { Error = "Group not found." });

                var lessonId = IdGenerator.GenerateUniqueId();
                var qrCodePath = QrcodeGenrator.GenerateQrCode(lessonId, "uploads/lessons/qr", lessonId);
                if (qrCodePath == null)
                    return StatusCode(StatusCodes.Status500InternalServerError, new { Error = "An error occurred while generating the QR code." });
                qrCodePath = qrCodePath.Replace("uploads/lessons/qr/", string.Empty).Replace("\\", "/");
                var lessonFactory = FactoryProvider.GetFactory<Lesson>();
                var lesson = lessonFactory.CreateEntity(new object[] { dto, lessonId, qrCodePath });

                await _unitOfWork.Lessons.AddAsync(lesson);
                await _unitOfWork.CompleteAsync();

                var response = new
                {
                    LessonId = lessonId,
                    Title = dto.Title,
                    Description = dto.Description,
                    CreatedAt = DateTime.UtcNow
                };

                return CreatedAtAction(nameof(CreateLesson), response);
            }
            catch (Exception ex)
            {

                return StatusCode(StatusCodes.Status500InternalServerError, new
                {
                    Error = "An error occurred while creating the lesson.",
                    Details = ex.Message
                });
            }
        }

        [HttpGet]
        public async Task<IActionResult> GetLessons()
        {
            var lessons = await _unitOfWork.Lessons.GetAllAsync();
            if (lessons == null)
                return NotFound(new { Error = "No lessons found." });
            var response = lessons.Select(lesson => new
            {
                LessonId = lesson.ID,
                Title = lesson.Title,
                Description = lesson.Description,
                CreatedAt = lesson.StartDateTime,
                GroupId = lesson.GroupId,
                IsAttendanceAllow = lesson.IsAttendanceAllow,
            });

            return Ok(response);
        }



        [HttpGet("{lessonId}")]
        public async Task<IActionResult> GetLesson(string lessonId)
        {
            var lesson = await _unitOfWork.Lessons.GetByIdAsync(lessonId);
            if (lesson == null)
                return NotFound(new { Error = "Lesson not found." });

            var qrCodeUrl = Url.Action(nameof(DownloadQRCode), new { lessonId });

            var response = new
            {
                LessonId = lesson.ID,
                Title = lesson.Title,
                Description = lesson.Description,
                CreatedAt = lesson.StartDateTime,
                GroupId = lesson.GroupId,
                IsAttendanceAllow = lesson.IsAttendanceAllow,
                QRCodeimage = qrCodeUrl,
            };

            return Ok(response);
        }

        [HttpPut("")]
        public async Task<IActionResult> UpdateLesson([FromBody] UpdateLessonDto dto)
        {
            var lesson = await _unitOfWork.Lessons.GetByIdAsync(dto.Id);
            if (lesson == null)
                return NotFound(new { Error = "Lesson not found." });
            lesson.Title = dto.Title ?? lesson.Title;
            lesson.Description = dto.Description ?? lesson.Description;
            lesson.StartDateTime = dto.StartTime;
            lesson.EndDateTime = dto.EndTime;
            lesson.IsAttendanceAllow = dto.IsAttendanceAllow;

            _unitOfWork.Lessons.Update(lesson);
            await _unitOfWork.CompleteAsync();

            return Ok(new
            {
                LessonId = lesson.ID,
                Title = lesson.Title,
                Description = lesson.Description,
                CreatedAt = lesson.StartDateTime,
                GroupId = lesson.GroupId,
                IsAttendanceAllow = lesson.IsAttendanceAllow,
            });
        }


        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteLesson(string id)
        {
            var lesson = await _unitOfWork.Lessons.GetByIdAsync(id);
            if (lesson == null)
                return NotFound(new { Error = "Lesson not found." });

            _unitOfWork.Lessons.Delete(lesson);
            await _unitOfWork.CompleteAsync();
            System.IO.File.Delete(Path.Combine("uploads/lessons/qr", lesson.QRCode));


            return Ok("Lesson deleted successfully.");

        }

        [HttpGet("qr-code/{lessonId}")]
        public async Task<IActionResult> DownloadQRCode(string lessonId)
        {
            var lesson = await _unitOfWork.Lessons.GetByIdAsync(lessonId);
            if (lesson == null)
                return NotFound(new { Error = "Lesson not found." });

            var qrCodePath = Path.Combine("uploads", "lessons", "qr", lesson.QRCode);
            if (!System.IO.File.Exists(qrCodePath))
                return NotFound(new { Error = "QR code file not found." });

            var contentType = "image/png";
            var fileStream = new FileStream(qrCodePath, FileMode.Open, FileAccess.Read);
            return File(fileStream, contentType, lesson.QRCode);
        }
    }
}