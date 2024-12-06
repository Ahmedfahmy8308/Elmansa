using API.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace API.Data.Config
{
    public class MaterialConfiguration : IEntityTypeConfiguration<Material>
    {
        public void Configure(EntityTypeBuilder<Material> builder)
        {
            // Primary Key
            builder.HasKey(x => x.ID);
            builder.Property(x => x.ID).ValueGeneratedOnAdd();

            // Properties
            builder.Property(x => x.Title).IsRequired().HasMaxLength(200);
            builder.Property(x => x.Type).IsRequired().HasMaxLength(50);
            builder.Property(x => x.FilePath).IsRequired();
            builder.Property(x => x.UploadDate).IsRequired();

            // Relationships
            builder.HasMany(x => x.LessonMaterials)
                   .WithOne(lm => lm.Material)
                   .HasForeignKey(lm => lm.MaterialID)
                   .OnDelete(DeleteBehavior.Cascade);
        }
    }
}
