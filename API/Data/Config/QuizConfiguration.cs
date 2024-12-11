using API.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace API.Data.Config
{
    public class QuizConfiguration : IEntityTypeConfiguration<Quiz>
    {
        public void Configure(EntityTypeBuilder<Quiz> builder)
        {
            // Primary Key
            builder.HasKey(x => x.ID);
            builder.Property(x => x.ID).ValueGeneratedOnAdd();

            // Properties
            builder.Property(x => x.Title).IsRequired().HasMaxLength(200);
            builder.Property(x => x.Description).IsRequired();
            builder.Property(x => x.CreationDate).IsRequired();
            builder.Property(x => x.StartDate).IsRequired();
            builder.Property(x => x.EndDate).IsRequired();
            builder.Property(x => x.IsPublished).IsRequired().HasDefaultValue(false);

            // Relationships
            builder.HasMany(x => x.Groups)
                   .WithOne(x => x.Quiz)
                   .HasForeignKey(x => x.GroupID)
                   .OnDelete(DeleteBehavior.Cascade);
        }
    }
}
