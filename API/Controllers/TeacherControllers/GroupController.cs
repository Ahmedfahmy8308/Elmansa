using API.Data;
using API.Entities;
using API.DTO.Teacher;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using API.UOW;

namespace API.Controllers.TeacherControllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class GroupController : ControllerBase
    {
        readonly IUnitOfWork _unitOfWork;
        public GroupController(IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork; 
        }



        [HttpGet]
        public async Task<IActionResult> Get()
        {
            var Opj = await _unitOfWork.Groups.GetAllAsync();
            var Groups = new List<Group_dto>();

            foreach (var item in Opj)
            {
                Group_dto group = new Group_dto();
                group.Group_id = item.ID;
                group.Group_name = item.Name;
                group.Groub_stage = item.Stage;
                group.Group_stage_level = item.StageLevel;
                group.Group_created_data = item.CreatedAt;
                group.Group_active = item.IsActive;
                Groups.Add(group);
            }
            return Ok(Groups);
        }

        [HttpGet]
        [Route("{id}")]
        public async Task<IActionResult> Get(int id)
        {
            var Opj = await _unitOfWork.Groups.GetByIdAsync(id);
            if (Opj == null)
            {
                return NotFound("No Such group ");
            }
            Group_dto group = new Group_dto();
            group.Group_id = Opj.ID;
            group.Group_name = Opj.Name;
            group.Groub_stage = Opj.Stage;
            group.Group_stage_level = Opj.StageLevel;
            group.Group_created_data = Opj.CreatedAt;
            group.Group_active = Opj.IsActive;
            return Ok(group);
        }

        [HttpPost]
        public async Task<IActionResult> Post(Group_dto group)
        {
            Group Opj = new Group();
            Opj.Name = group.Group_name;
            Opj.Stage = group.Groub_stage;
            Opj.StageLevel = group.Group_stage_level;
            Opj.CreatedAt = group.Group_created_data;
            Opj.IsActive = group.Group_active;

            await _unitOfWork.Groups.AddAsync(Opj);
            await _unitOfWork.CompleteAsync();
            return Ok(group);
        }


        [HttpDelete]
        public async Task<IActionResult> Delete(Group_dto group )
        {
            var Opj = await _unitOfWork.Groups.GetByIdAsync(group.Group_id);
            if (Opj == null)
            {
                return NotFound("No Such group ");
            }
            _unitOfWork.Groups.Delete(Opj);
            await _unitOfWork.CompleteAsync();
            return Ok();
        }

        [HttpPut]
        public async Task<IActionResult> Put(Group_dto group)
        {
            var Opj = await _unitOfWork.Groups.GetByIdAsync(group.Group_id);
            if (Opj == null)
            {
                return NotFound("No Such group ");
            }
            Opj.Name = group.Group_name;
            Opj.Stage = group.Groub_stage;
            Opj.StageLevel = group.Group_stage_level;
            Opj.CreatedAt = group.Group_created_data;
            Opj.IsActive = group.Group_active;

            _unitOfWork.Groups.Update(Opj);
            await _unitOfWork.CompleteAsync();
            return Ok(group);
        }

    }
}
