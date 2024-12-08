using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace API.Entities;

public class LessonMaterial
{
    public int LessonID { get; set; }
    public int MaterialID { get; set; }

    public Lesson Lesson { get; set; } = null!;
    public Material Material { get; set; } = null!;
}

