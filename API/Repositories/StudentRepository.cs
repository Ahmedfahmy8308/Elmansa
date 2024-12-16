using API.Entities;
using API.Repositories;

namespace API.Data.Repositories
{
    public class StudentRepository : GenericRepository<Student> , IStudentRepository
    {
        readonly AppDbContext _context;
        public StudentRepository(AppDbContext context) : base(context)
        {
            _context = context;
        }

        public bool IsSsnExit(string ssn)
        {
            return _context.Students.Any(s => s.SSN == ssn) ;
        }

        public bool IsStudentAllowed(string Email)
        {
            var allowedStudent = _context.AllowedStudents.Find(Email);
            return allowedStudent != null && allowedStudent.AccountActive;
        }
    }
}
