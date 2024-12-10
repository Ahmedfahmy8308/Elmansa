using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace API.Entities;

public class QuizSubmission
{
    public int ID { get; set; }
    public string StudentID { get; set; } = null!;
    public int QuizID { get; set; }
    public double? Score { get; set; }
    public DateTime SubmissionDate { get; set; }
    public string Answers { get; set; } = null!;

    public Student Student { get; set; } = null!;
    public Quiz Quiz { get; set; } = null!; 
}
