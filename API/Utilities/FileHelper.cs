using API.DTO.Student;
using Microsoft.AspNetCore.Http;
using SixLabors.ImageSharp;
using SixLabors.ImageSharp.Processing;
using System;
using System.IO;
using System.Linq;
using System.Threading.Tasks;

namespace API.Utilities
{
    public class FileHelper
    {
        private static readonly int MaxWidth = 800; 
        private static readonly int MaxHeight = 800; 

        public static async Task<string> SaveStudentPhoto(IFormFile studentPhoto, string filePath)
        {
            try
            {
                using (var image = await Image.LoadAsync(studentPhoto.OpenReadStream()))
                {
                    if (image.Width > MaxWidth || image.Height > MaxHeight)
                    {
                        int width = image.Width;
                        int height = image.Height;

                        if (width > height)
                        {
                            height = (int)(height * ((float)MaxWidth / width));
                            width = MaxWidth;
                        }
                        else
                        {
                            width = (int)(width * ((float)MaxHeight / height));
                            height = MaxHeight;
                        }

                        image.Mutate(x => x.Resize(width, height));
                    }

                    await image.SaveAsync(filePath); 
                }

                return filePath;
            }
            catch (Exception ex)
            {
                throw new InvalidOperationException("Error while saving student photo: " + ex.Message);
            }
        }
    }
}
