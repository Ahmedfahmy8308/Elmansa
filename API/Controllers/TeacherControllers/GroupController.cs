using API.Data;
using API.Entities;
using API.DTO.Teacher;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace API.Controllers.TeacherControllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class GroupController : ControllerBase
    {
        readonly AppDbContext _mydb;
        public GroupController(AppDbContext mydb)
        {
            _mydb = mydb;
        }



        [HttpGet]
        public async Task<IActionResult> Get()
        {
            var Opj = await _mydb.Groups.ToListAsync();
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

        [HttpPost]
        public async Task<IActionResult> Post(Group_dto group)
        {
            Group Opj = new Group();
            Opj.Name = group.Group_name;
            Opj.Stage = group.Groub_stage;
            Opj.StageLevel = group.Group_stage_level;
            Opj.CreatedAt = group.Group_created_data;
            Opj.IsActive = group.Group_active;

            await _mydb.Groups.AddAsync(Opj);
            await _mydb.SaveChangesAsync();
            return Ok(group);
        }


        [HttpDelete]
        public async Task<IActionResult> Delete(Group_dto group )
        {
            var Opj = await _mydb.Groups.FirstOrDefaultAsync(x => x.ID == group.Group_id);
            if (Opj == null)
            {
                return NotFound("No Such group ");
            }
            _mydb.Groups.Remove(Opj);
            await _mydb.SaveChangesAsync();
            return Ok();
        }

        [HttpPut]
        public async Task<IActionResult> Put(Group_dto group)
        {
            var Opj = await _mydb.Groups.FirstOrDefaultAsync(x => x.ID == group.Group_id);
            if (Opj == null)
            {
                return NotFound("No Such group ");
            }
            Opj.Name = group.Group_name;
            Opj.Stage = group.Groub_stage;
            Opj.StageLevel = group.Group_stage_level;
            Opj.CreatedAt = group.Group_created_data;
            Opj.IsActive = group.Group_active;

            await _mydb.SaveChangesAsync();
            return Ok(group);
        }

    }
}
