using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace API.Entities;
public class UserNotification
{
    public int ID { get; set; }
    public int NotificationId { get; set; }
    public int StudentID { get; set; }
    public bool IsRead { get; set; }
    public DateTime? ReadAt { get; set; }

    public Notification Notification { get; set; } = null!;
    public Student Student { get; set; } = null!;
}