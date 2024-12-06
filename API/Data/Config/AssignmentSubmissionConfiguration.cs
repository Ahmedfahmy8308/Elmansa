using API.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace API.Data.Config
{
    public class AssignmentSubmissionConfiguration : IEntityTypeConfiguration<AssignmentSubmission>
    {
        public void Configure(EntityTypeBuilder<AssignmentSubmission> builder)
        {
            // Primary Key
            builder.HasKey(x => x.ID);
            builder.Property(x => x.ID).ValueGeneratedOnAdd();

            // Properties
            builder.Property(x => x.StudentID).IsRequired();
            builder.Property(x => x.AssignmentID).IsRequired();
            builder.Property(x => x.FilePath).IsRequired();
            builder.Property(x => x.SubmissionDate).IsRequired();
            

            // Relationships
            builder.HasOne(x => x.Student)
                   .WithMany(s => s.AssignmentSubmissions)
                   .HasForeignKey(x => x.StudentID)
                   .OnDelete(DeleteBehavior.Cascade);

            builder.HasOne(x => x.Assignment)
                   .WithMany(a => a.AssignmentSubmissions)
                   .HasForeignKey(x => x.AssignmentID)
                   .OnDelete(DeleteBehavior.Cascade);
        }
    }
}
