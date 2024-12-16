using API.DTO.Student;
using API.Entities;

namespace API.Factories
{
    public class StudentFactory : IEntityFactory<Student>
    {
        public Student CreateEntity(params object[] parameters)
        {
            if (parameters.Length != 4)
                throw new ArgumentException("Invalid number of parameters for StudentFactory.");

            var registerDto = parameters[0] as Register_dto;
            var allowedStudent = parameters[1] as AllowedStudent;
            var photoPath = parameters[2] as string;
            var ID = parameters[3] as string;

            if (registerDto == null || allowedStudent == null || photoPath == null || ID == null)
                throw new ArgumentException("Invalid parameters provided for StudentFactory.");

            return new Student
            {
                ID = ID,
                Fname = registerDto.Student_first_name,
                Mname = registerDto.Student_Middel_name,
                Lname = registerDto.Student_last_name,
                Email = registerDto.Student_email,
                DateOfBirth = registerDto.Student_date_birth,
                Number = registerDto.Student_number,
                SSN = registerDto.Student_SSN,
                GuardianNumber = registerDto.Student_guardian_number,
                Password = registerDto.Student_password,
                PhotoPath = photoPath,
                Stage = allowedStudent.Stage,
                StageLevel = allowedStudent.StageLevel,
                GroupId = allowedStudent.GroupID
            };
        }
    }
}
