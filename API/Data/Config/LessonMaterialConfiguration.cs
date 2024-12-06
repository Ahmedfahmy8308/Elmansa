using API.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace API.Data.Config
{
    public class LessonMaterialConfiguration : IEntityTypeConfiguration<LessonMaterial>
    {
        public void Configure(EntityTypeBuilder<LessonMaterial> builder)
        {
            // Primary Key
            builder.HasKey(lm => new { lm.LessonID, lm.MaterialID });


            // Relationships
            builder.HasOne(x => x.Lesson)
                   .WithMany(l => l.LessonMaterials)
                   .HasForeignKey(x => x.LessonID)
                   .OnDelete(DeleteBehavior.Cascade);

            builder.HasOne(x => x.Material)
                   .WithMany(m => m.LessonMaterials)
                   .HasForeignKey(x => x.MaterialID)
                   .OnDelete(DeleteBehavior.Cascade);
        }
    }
}
