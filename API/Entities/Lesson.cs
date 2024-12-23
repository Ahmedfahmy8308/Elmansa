using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace API.Entities;

public class Lesson
{
    public string ID { get; set; } = null!;
    public string Title { get; set; } = null!;
    public string Description { get; set; } = null!;
    public string QRCode { get; set; } = null!;
    public DateTime StartDateTime { get; set; } 
    public DateTime EndDateTime { get; set; }
    public int GroupId { get; set; }

    public bool IsAttendanceAllow { get; set; }

    public Group Group { get; set; } = null!;
    public ICollection<LessonMaterial>? LessonMaterials { get; set; }
    public ICollection<Assignment>? Assignments { get; set; }
    public ICollection<Attendance>? Attendances { get; set; }
}
