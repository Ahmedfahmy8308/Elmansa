using API.Entities;
using API.Repositories;

namespace API.Data.Repositories
{
    public interface IStudentRepository : IRepository<Student>
    {
        bool IsStudentAllowed(string studentId);
        bool IsSsnExit(string ssn);

    }
}

