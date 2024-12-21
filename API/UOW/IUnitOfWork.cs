using API.Data;
using API.Data.Repositories;
using API.Entities;
using API.Repositories;
using Microsoft.AspNetCore.Identity;
using System;
using System.Threading.Tasks;

namespace API.UOW
{
    public interface IUnitOfWork : IDisposable
    {
        IStudentRepository Students { get; }
        IRepository<AllowedStudent> AllowedStudents { get; }
        IRepository<Group> Groups { get; }

        Task<int> CompleteAsync();
    }
}
