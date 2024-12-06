using API.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace API.Data.Config
{
    public class QuizQuestionConfiguration : IEntityTypeConfiguration<QuizQuestion>
    {
        public void Configure(EntityTypeBuilder<QuizQuestion> builder)
        {
            // Primary Key
            builder.HasKey(x => x.ID);
            builder.Property(x => x.ID).ValueGeneratedOnAdd();

            // Properties
            builder.Property(x => x.Text).IsRequired();
            builder.Property(x => x.CorrectAnswer).IsRequired();

            // Relationships
            builder.HasOne(x => x.Quiz)
                   .WithMany(q => q.QuizQuestions)
                   .HasForeignKey(x => x.QuizId)
                   .OnDelete(DeleteBehavior.Cascade);

            builder.HasMany(x => x.QuizOptions)
                   .WithOne(o => o.QuizQuestion)
                   .HasForeignKey(o => o.QuestionId)
                   .OnDelete(DeleteBehavior.Cascade);
        }
    }
}
