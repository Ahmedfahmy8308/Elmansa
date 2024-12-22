using API.DTO.Teacher;
using API.Entities;
using API.UOW;
using API.Utilities;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

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

            var lessonid = IdGenerator.GenerateUniqueId();
            var QrCode = QrcodeGenrator.GenerateQrCode(lessonid, "uplodas/lessons/qr", lessonid);


            var lessonfactory = FactoryProvider.GetFactory<Lesson>();
            var lesson = lessonfactory.CreateEntity(new object[] { dto, lessonid, QrCode });

            await _unitOfWork.Lessons.AddAsync(lesson);
            await _unitOfWork.CompleteAsync();

            return Ok();
        }



    }
}
