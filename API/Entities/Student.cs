using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace API.Entities;

public class Student
{
    public string ID { get; set; }
    public string Fname { get; set; } = null!;
    public string Mname { get; set; } = null!;
    public string Lname { get; set; } = null!;
    public string Email { get; set; } = null!;
    public string Stage { get; set; } = null!;
    public int StageLevel { get; set; }
    public DateTime DateOfBirth { get; set; }
    public string PhotoPath { get; set; } = null!;
    public string Password { get; set; } = null!;
    public string Number { get; set; } = null!;
    public string SSN { get; set; } = null!;
    public string GuardianNumber { get; set; } = null!;
    public int? GroupId { get; set; }


    public Group? Group { get; set; }
    public AllowedStudent AllowedStudent { get; set; } = null!;

    public ICollection<Attendance> Attendances { get; set; } = null!;
    public ICollection<UserNotification> UserNotifications { get; set; } = null!;
    public ICollection<QuizSubmission> QuizSubmissions { get; set; } = null!;
    public ICollection<AssignmentSubmission> AssignmentSubmissions { get; set; } = null!;
}
