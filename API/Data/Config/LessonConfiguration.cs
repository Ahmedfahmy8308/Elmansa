using API.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace API.Data.Config
{
    public class LessonConfiguration : IEntityTypeConfiguration<Lesson>
    {
        public void Configure(EntityTypeBuilder<Lesson> builder)
        {
            // Primary Key
            builder.HasKey(x => x.ID);
            builder.Property(x => x.ID).ValueGeneratedOnAdd();

            // Properties
            builder.Property(x => x.Title).IsRequired().HasMaxLength(200);
            builder.Property(x => x.Description).IsRequired();
            builder.Property(x => x.QRCode).IsRequired();
            builder.Property(x => x.StartDateTime).IsRequired();
            builder.Property(x => x.IsAttendanceAllow).IsRequired();
            builder.Property(x => x.EndDateTime).IsRequired();

            // Relationships
            builder.HasMany(x => x.Attendances)
                   .WithOne(a => a.Lesson)
                   .HasForeignKey(a => a.LessonId)
                   .OnDelete(DeleteBehavior.Cascade);

            builder.HasMany(x => x.Assignments)
                   .WithOne(a => a.Lesson)
                   .HasForeignKey(a => a.LessonID)
                   .OnDelete(DeleteBehavior.Cascade);
            builder.HasMany(x => x.LessonMaterials)
                   .WithOne(a => a.Lesson)
                   .HasForeignKey(a => a.LessonID)
                   .OnDelete(DeleteBehavior.Cascade);

            builder.HasOne(x => x.Group)
                   .WithMany(g => g.Lessons)
                   .HasForeignKey(x => x.GroupId)
                   .OnDelete(DeleteBehavior.Cascade);
        }
    }
}
