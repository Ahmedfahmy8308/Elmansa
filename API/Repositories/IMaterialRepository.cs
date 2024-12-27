using API.Entities;

namespace API.Repositories
{
    public interface IMaterialRepository : IRepository<Material>
    {

        List<Lesson> GetLessons(string matrialid);


    }
}
