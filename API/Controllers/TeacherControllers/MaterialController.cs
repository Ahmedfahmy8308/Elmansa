using API.DTO.Teacher;
using API.Entities;
using API.UOW;
using API.Utilities;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace API.Controllers.TeacherControllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class MaterialController : ControllerBase
    {
        private readonly IUnitOfWork _unitOfWork;
        public MaterialController(IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;
        }


        [HttpGet]
        public async Task<IActionResult> Get()
        {
            var Opj = await _unitOfWork.Materials.GetAllAsync();
            var Materials = new List<Material_dto>();

            foreach (var item in Opj)
            {
                Material_dto material = new Material_dto();
                material.Material_id = item.ID;
                material.Material_title = item.Title;
                material.Material_type = item.Type;
                material.filepath = item.FilePath;
                material.Material_upload_date = item.UploadDate;
                Materials.Add(material);
            }
            return Ok(Materials);
        }

        [HttpGet]
        [Route("{id}")]
        public async Task<IActionResult> Get(int id)
        {
            var Opj = await _unitOfWork.Materials.GetByIdAsync(id);
            if (Opj == null)
            {
                return NotFound("No Such Material ");
            }
            Material_dto material = new Material_dto();
            material.Material_id = Opj.ID;
            material.Material_title = Opj.Title;
            material.Material_type = Opj.Type;
            material.filepath = Opj.FilePath;
            material.Material_upload_date = Opj.UploadDate;
            var lessons = _unitOfWork.Materials.GetLessons(Opj.ID);
            return Ok(material);
        }

        [HttpPost]
        public async Task<IActionResult> Post([FromForm] Material_U_dto material)
        {
            if (material.File == null || material.File.Length == 0)
            {
                return BadRequest("No file uploaded.");
            }
            var allowedfiles = new string[] { "video" , "image" , "pdf" };
            var allowedExtensions = new string[] { ".mp4",".mkv" ,".jpg", ".jpeg", ".png", ".pdf" };
            if (!allowedfiles.Contains(material.Material_type))
            {
                return BadRequest("Invalid Material Type");
            }
            if (!allowedExtensions.Contains(Path.GetExtension(material.File.FileName)))
            {
                return BadRequest("Invalid File Type");
            }
            var uploadsFolder = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot","Uploads","material", material.Material_type);
            if (!Directory.Exists(uploadsFolder))
            {
                Directory.CreateDirectory(uploadsFolder);
            }
            var id = IdGenerator.GenerateUniqueId();

            var filePath = Path.Combine(uploadsFolder, id);

            try
            {
                using (var fileStream = new FileStream(filePath, FileMode.Create, FileAccess.Write, FileShare.None))
                {
                    await material.File.CopyToAsync(fileStream);
                }

            }
            catch (IOException ex)
            {
                return StatusCode(500, $"File access error: {ex.Message}");
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Internal server error: {ex.Message}");
            }

            var materialObj = new Material
            {
                ID = id,
                Title = material.Material_title,
                Type = material.Material_type,
                FilePath = filePath,
                UploadDate = DateTime.Now
            };

            await _unitOfWork.Materials.AddAsync(materialObj);
            await _unitOfWork.CompleteAsync();


            return Ok();
        }


        [HttpDelete]
        [Route("{id}")]
        public async Task<IActionResult> Delete(int id)
        {
            var Opj = await _unitOfWork.Materials.GetByIdAsync(id);
            if (Opj == null)
            {
                return NotFound("No Such Material");
            }
            try
            {
                System.IO.File.Delete(Opj.FilePath); // Explicitly specify System.IO.File
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Internal server error: {ex.Message}");
            }

            _unitOfWork.Materials.Delete(Opj);

            await _unitOfWork.CompleteAsync();
            return Ok();
        }


    }
}
