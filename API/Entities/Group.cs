using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace API.Entities;
public class Group
{
    public int ID { get; set; }

    public string Name { get; set; } = null!;

    public string Stage { get; set; } = null!;

    public int StageLevel { get; set; }

    public DateTime CreatedAt { get; set; }

    public bool IsActive { get; set; }


    public ICollection<Lesson>? Lessons { get; set; }
    public ICollection<Student>? Students { get; set; }
    public ICollection<AllowedStudent>? AllowedStudents { get; set; }
    public ICollection<GroupQuiz>? Quizzes { get; set; }
    public ICollection<Notification>? Notifications { get; set; }

}