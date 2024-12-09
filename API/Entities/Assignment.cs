using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace API.Entities;

public class Assignment
{
    public int ID { get; set; }
    public string Title { get; set; } =null!;
    public string Description { get; set; } = null!;
    public string? FilePath { get; set; }
    public DateTime StartDate { get; set; }
    public DateTime EndDate { get; set; }
    public int LessonID { get; set; }


    public Lesson Lesson { get; set; } = null!;
    public ICollection<AssignmentSubmission>? AssignmentSubmissions { get; set; }
}
