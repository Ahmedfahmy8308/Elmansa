using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace API.Entities;
public class QuizQuestion
{
    public int ID { get; set; }
    public int QuizId { get; set; }
    public string Text { get; set; } = null!;
    public string CorrectAnswer { get; set; } = null!;

    public Quiz Quiz { get; set; } = null!;
    public ICollection<QuizOption>? QuizOptions { get; set; }
}

