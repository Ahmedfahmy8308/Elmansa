using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace API.Entities;

public class AssignmentSubmission
{
    public int ID { get; set; }
    public string StudentID { get; set; } = null!;
    public int AssignmentID { get; set; }
    public string FilePath { get; set; } = null!;
    public DateTime SubmissionDate { get; set; }

    public Student Student { get; set; } = null!;
    public Assignment Assignment { get; set; } = null!;
}
