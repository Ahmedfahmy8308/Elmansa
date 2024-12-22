using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace API.Entities;
public class UserNotification
{
    public string ID { get; set; } = null!;
    public string NotificationId { get; set; } = null!;
    public string StudentID { get; set; } = null!;
    public bool IsRead { get; set; }
    public DateTime? ReadAt { get; set; }

    public Notification Notification { get; set; } = null!;
    public Student Student { get; set; } = null!;
}