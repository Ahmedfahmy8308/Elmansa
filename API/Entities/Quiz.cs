using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace API.Entities;

public class Quiz
{
    public string ID { get; set; } = null!;
    public string Title { get; set; } = null!;
    public string Description { get; set; } = null!;
    public DateTime CreationDate { get; set; }
    public DateTime StartDate { get; set; }
    public DateTime EndDate { get; set; }

    public bool IsPublished { get; set; }

    public int? GroupId { get; set; }

    public ICollection<QuizQuestion>? QuizQuestions { get; set; }
    public ICollection<QuizSubmission>? QuizSubmissions { get; set; }
}

