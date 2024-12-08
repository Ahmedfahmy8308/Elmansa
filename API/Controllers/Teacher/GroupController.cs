using API.Data;
using API.Entities;
using API.DTO.Teacher;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace API.Controllers.Teacher
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
            var Groups = new List<Group_Add_dto>();

            foreach (var item in Opj)
            {
                Group_Add_dto group = new Group_Add_dto();
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
        public async Task<IActionResult> Post(Group_Add_dto group)
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


        [HttpDelete("{Group_id}")]
        
        public async Task<IActionResult> Delete(int Group_id)
        {
            var Group = await _mydb.Groups.FirstOrDefaultAsync(x => x.ID == Group_id);
            if (Group == null)
            {
                return NotFound("No Such group");
            }
            _mydb.Groups.Remove(Group);
            await _mydb.SaveChangesAsync();
            return Ok();
        }
    }
}
