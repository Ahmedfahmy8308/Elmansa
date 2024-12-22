using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace API.Entities;

public class LessonMaterial
{
    public string LessonID { get; set; } = null!;
    public string MaterialID { get; set; } = null!;

    public Lesson Lesson { get; set; } = null!;
    public Material Material { get; set; } = null!;
}

