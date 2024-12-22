using API.DTO.Teacher;
using API.UOW;
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
                material.formFile = null;
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
            material.formFile = null;
            material.Material_upload_date = Opj.UploadDate;
            return Ok(material);
        }




    }
}
