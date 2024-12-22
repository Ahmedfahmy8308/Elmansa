using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace API.Entities;

public class QuizOption
{
    public int ID { get; set; }
    public int QuestionId { get; set;}
    public string OptionText { get; set; } = null!;
    public bool IsCorrect { get; set; }

    public QuizQuestion QuizQuestion { get; set; } = null!;
}
