using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace API.Entities;

public class Notification
{
    public int ID { get; set; }
    public string Title { get; set; } = null!;
    public string NotificationContent { get; set; } = null!;
    public DateTime CreationDate { get; set; }

    public bool Global { get; set; }

    public int? GroupId { get; set; }

    public Group? Group { get; set; }
    public ICollection<UserNotification>? UserNotifications { get; set; }
}

