using API.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace API.Data.Config
{
    public class AssignmentConfiguration : IEntityTypeConfiguration<Assignment>
    {
        public void Configure(EntityTypeBuilder<Assignment> builder)
        {
            // Primary Key
            builder.HasKey(x => x.ID);
            builder.Property(x => x.ID).ValueGeneratedOnAdd();

            // Properties
            builder.Property(x => x.Title).IsRequired().HasMaxLength(200);
            builder.Property(x => x.Description).IsRequired();
            builder.Property(x => x.StartDate).IsRequired();
            builder.Property(x => x.EndDate).IsRequired();

            // Relationships
            builder.HasMany(x=>x.AssignmentSubmissions)
                   .WithOne(a => a.Assignment)
                   .HasForeignKey(a => a.AssignmentID)
                   .OnDelete(DeleteBehavior.Cascade);

            builder.HasOne(x => x.Lesson)
                   .WithMany(g => g.Assignments)
                   .HasForeignKey(x => x.LessonID)
                   .OnDelete(DeleteBehavior.SetNull);

        }
    }
}
