using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace API.Entities;

public class Material
{
    public string ID { get; set; } = null!;
    public string Title { get; set; } = null!;
    public string Type { get; set; } = null!;
    public string FilePath { get; set; } = null!;
    public DateTime UploadDate { get; set; }

    public ICollection<LessonMaterial>? LessonMaterials { get; set; }
}
