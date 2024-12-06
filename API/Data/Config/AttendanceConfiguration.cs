using API.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace API.Data.Config
{
    public class AttendanceConfiguration : IEntityTypeConfiguration<Attendance>
    {
        public void Configure(EntityTypeBuilder<Attendance> builder)
        {
            // Primary Key
            builder.HasKey(x => x.ID);
            builder.Property(x => x.ID).ValueGeneratedOnAdd();

            // Properties
            builder.Property(x => x.StudentId).IsRequired();
            builder.Property(x => x.LessonId).IsRequired();

            // Relationships
            builder.HasOne(x => x.Student)
                   .WithMany(s => s.Attendances)
                   .HasForeignKey(x => x.StudentId)
                   .OnDelete(DeleteBehavior.Cascade);

            builder.HasOne(x => x.Lesson)
                   .WithMany(l => l.Attendances)
                   .HasForeignKey(x => x.LessonId)
                   .OnDelete(DeleteBehavior.Cascade);
        }
    }
}
