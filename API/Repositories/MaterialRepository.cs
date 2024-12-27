using API.Data;
using API.Entities;

namespace API.Repositories
{
    public class MaterialRepository : GenericRepository<Material>, IMaterialRepository
    {
        readonly AppDbContext _context;
        public MaterialRepository(AppDbContext context) : base(context)
        {
            _context = context;
        }

        public List<Lesson> GetLessons(string matrialid)
        {
            return _context.LessonMaterials
                .Where(x => x.MaterialID == matrialid)
                .Select(x => x.Lesson)
                .ToList();
        }
    }
}
