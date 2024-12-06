using API.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace API.Data.Config
{
    public class QuizSubmissionConfiguration : IEntityTypeConfiguration<QuizSubmission>
    {
        public void Configure(EntityTypeBuilder<QuizSubmission> builder)
        {
            // Primary Key
            builder.HasKey(x => x.ID);
            builder.Property(x => x.ID).ValueGeneratedOnAdd();

            // Properties
            builder.Property(x => x.StudentID).IsRequired();
            builder.Property(x => x.QuizID).IsRequired();
            builder.Property(x => x.SubmissionDate).IsRequired();
            builder.Property(x => x.Answers).IsRequired();

            // Relationships
            builder.HasOne(x => x.Student)
                   .WithMany(s => s.QuizSubmissions)
                   .HasForeignKey(x => x.StudentID)
                   .OnDelete(DeleteBehavior.Cascade);

            builder.HasOne(x => x.Quiz)
                   .WithMany(q => q.QuizSubmissions)
                   .HasForeignKey(x => x.QuizID)
                   .OnDelete(DeleteBehavior.Cascade);
        }
    }
}
