using API.DTO.Student;
using System;
using System.Text.RegularExpressions;

namespace API.Utilities
{
    public class Validator
    {
        private static readonly string[] AllowedExtensions = { ".jpg", ".jpeg", ".png" };
        private const long MaxFileSize = 5 * 1024 * 1024;

        public static string ValidateStudentInfo(Register_dto register)
        {
            string fileExtension = Path.GetExtension(register.Student_photo.FileName)?.ToLower();

            if (!AllowedExtensions.Contains(fileExtension))
                return "Invalid Photo format. Only JPG, JPEG, and PNG files are allowed.";

            if (register.Student_photo.Length > MaxFileSize)
                return "File size should be less than 5MB.";
           
            if (register.Student_number.Length != 11 )
                return "Invalid phone number. It should be 11 digits.";

            if (register.Student_guardian_number.Length != 11 )
                return "Invalid guardian phone number. It should be 11 digits.";

            if (register.Student_SSN.Length != 14 )
                return "Invalid SSN. It should be 14 digits.";

            if (register.Student_number == register.Student_guardian_number)
                return "Phone number and guardian phone number can't be the same.";

            return null;
            
   
        }

    }
}
