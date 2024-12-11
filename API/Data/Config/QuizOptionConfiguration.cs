using API.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace API.Data.Config
{
    public class QuizOptionConfiguration : IEntityTypeConfiguration<QuizOption>
    {
        public void Configure(EntityTypeBuilder<QuizOption> builder)
        {
            // Primary Key
            builder.HasKey(x => x.ID);
            builder.Property(x => x.ID).ValueGeneratedOnAdd();

            // Properties
            builder.Property(x => x.OptionText).IsRequired();
            builder.Property(x => x.IsCorrect).IsRequired().HasDefaultValue(false);

            // Relationships
            builder.HasOne(x => x.QuizQuestion)
                   .WithMany(q => q.QuizOptions)
                   .HasForeignKey(x => x.QuestionId)
                   .OnDelete(DeleteBehavior.Cascade);
        }
    }
}
