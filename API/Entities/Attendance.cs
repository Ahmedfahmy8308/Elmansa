using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace API.Entities;
public class Attendance
{
    public int ID { get; set; }
    public string StudentId { get; set; } = null!;
    public int LessonId { get; set; }

    public Student Student { get; set; } = null!;
    public Lesson Lesson { get; set; } = null!;
}
