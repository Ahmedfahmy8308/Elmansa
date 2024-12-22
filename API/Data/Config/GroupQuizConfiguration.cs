using API.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace API.Data.Config
{
    public class GroupQuizConfiguration : IEntityTypeConfiguration<GroupQuiz>
    {
        public void Configure(EntityTypeBuilder<GroupQuiz> builder)
        {
            // Primary Key
            builder.HasKey(lm => new { lm.GroupID, lm.QuizID });


            // Relationships
            //builder.HasOne(x => x.Group)
            //       .WithMany(l => l.Quizzes)
            //       .HasForeignKey(x => x.GroupID)
            //       .OnDelete(DeleteBehavior.Cascade);

            //builder.HasOne(x => x.Quiz)
            //       .WithMany(m => m.Groups)
            //       .HasForeignKey(x => x.QuizID)
            //       .OnDelete(DeleteBehavior.Cascade);
        }
    }
}
