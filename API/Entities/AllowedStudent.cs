 using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text.Json.Serialization;
using Microsoft.EntityFrameworkCore;

namespace API.Entities;

public class AllowedStudent
{
    public string Email { get; set; } = null!;
    public string Stage { get; set; } = null!;
    public int StageLevel { get; set; } 
    public int? GroupID { get; set; } 
    public bool AccountActive { get; set; }
    public Group? Group { get; set; }
     
    [JsonIgnore]
    public Student? Student { get; set; }
}
