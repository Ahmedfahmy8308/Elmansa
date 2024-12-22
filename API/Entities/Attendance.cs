using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace API.Entities;
public class Attendance
{
    public string ID { get; set; } = null!;
    public string StudentId { get; set; } = null!;
    public string LessonId { get; set; } = null!;

    public Student Student { get; set; } = null!;
    public Lesson Lesson { get; set; } = null!;
}
