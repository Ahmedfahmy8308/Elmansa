using API.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace API.Data.Config
{
    public class NotificationConfiguration : IEntityTypeConfiguration<Notification>
    {
        public void Configure(EntityTypeBuilder<Notification> builder)
        {
            // Primary Key
            builder.HasKey(x => x.ID);
            builder.Property(x => x.ID).ValueGeneratedOnAdd();

            // Properties
            builder.Property(x => x.Title).IsRequired().HasMaxLength(200);
            builder.Property(x => x.NotificationContent).IsRequired();
            builder.Property(x => x.CreationDate).IsRequired();
            builder.Property(x => x.Global).IsRequired().HasDefaultValue(false);

            // Relationships
            builder.HasOne(x => x.Group)
                   .WithMany(x => x.Notifications)
                   .HasForeignKey(x => x.GroupId)
                   .OnDelete(DeleteBehavior.SetNull);

            builder.HasMany(x => x.UserNotifications)
                   .WithOne(x => x.Notification)
                   .HasForeignKey(x => x.NotificationId)
                   .OnDelete(DeleteBehavior.Cascade);
        }
    }
}
