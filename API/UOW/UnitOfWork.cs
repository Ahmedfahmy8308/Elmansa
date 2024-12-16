using API.Data;
using API.Data.Repositories;
using API.Entities;
using API.Repositories;
using Microsoft.AspNetCore.Identity;
using System.Threading.Tasks;

namespace API.UOW
{
    public class UnitOfWork : IUnitOfWork
    {
        private readonly AppDbContext _context;

        public IStudentRepository Students { get; }

        public IRepository<AllowedStudent> AllowedStudents { get; }

        public UnitOfWork( AppDbContext context )
        {
            _context = context;
            Students = new StudentRepository(_context);
            AllowedStudents = new GenericRepository<AllowedStudent>(_context);
        }

        public async Task<int> CompleteAsync()
        {
            return await _context.SaveChangesAsync();
        }

        public void Dispose()
        {
            _context.Dispose();
        }
    }
}
