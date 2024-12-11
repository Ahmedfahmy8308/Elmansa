using API.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace API.Data.Config
{
    public class UserNotificationConfiguration : IEntityTypeConfiguration<UserNotification>
    {
        public void Configure(EntityTypeBuilder<UserNotification> builder)
        {
            // Primary Key
            builder.HasKey(x => x.ID);
            builder.Property(x => x.ID).ValueGeneratedOnAdd();

            // Properties
            builder.Property(x => x.NotificationId).IsRequired();
            builder.Property(x => x.StudentID).IsRequired();
            builder.Property(x => x.IsRead).IsRequired().HasDefaultValue(false);
            builder.Property(x => x.ReadAt);

            // Relationships
            builder.HasOne(x => x.Student)
                   .WithMany(s => s.UserNotifications)
                   .HasForeignKey(x => x.StudentID)
                   .OnDelete(DeleteBehavior.Cascade);

            builder.HasOne(x => x.Notification)
                   .WithMany(n => n.UserNotifications)
                   .HasForeignKey(x => x.NotificationId)
                   .OnDelete(DeleteBehavior.Cascade);
        }
    }
}
