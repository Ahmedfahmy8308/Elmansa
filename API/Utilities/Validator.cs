using API.DTO.Student;
using Microsoft.AspNetCore.Http;
using System;
using System.IO;
using System.Threading.Tasks;

namespace API.Utilities
{
    public class Validator
    {
        public static string ValidateStudentInfo(Register_dto register)
        {
            if (register.Student_number.Length != 11)
                return "Invalid phone number.";
            if (register.Student_guardian_number.Length != 11)
                return "Invalid guardian phone number.";
            if (register.Student_SSN.Length != 14)
                return "Invalid SSN.";
            if (register.Student_number == register.Student_guardian_number)
                return "Phone number and guardian phone number can't be the same.";

            return null;
        }
    }
}
