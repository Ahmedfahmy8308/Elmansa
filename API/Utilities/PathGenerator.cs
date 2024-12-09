using System;
using System.IO;
using System.Linq;

namespace API.Utilities
{
   
    public class PathResult
    {
        public string RelativePath { get; init; }  
        public string AbsolutePath { get; init; }  
    }

    public static class PathGenerator
    {
      
        public static PathResult GenerateStudentImagePath(string filename, string userid)
        {
            string uploadsFolder = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "StudentPhotos");

            Directory.CreateDirectory(uploadsFolder);

            string fileExtension = Path.GetExtension(filename)?.ToLowerInvariant();

            var allowedExtensions = new[] { ".jpg", ".jpeg", ".png" };
            if (!allowedExtensions.Contains(fileExtension))
                throw new InvalidOperationException("Invalid file format. Only JPG, JPEG, and PNG files are allowed.");

            string uniqueFileName = $"{userid}{fileExtension}";

            string relativePath = Path.Combine("StudentPhotos", uniqueFileName).Replace("\\", "/");

            string absolutePath = Path.Combine(uploadsFolder, uniqueFileName);

            return new PathResult
            {
                RelativePath = relativePath,
                AbsolutePath = absolutePath
            };
        }
    }
}
