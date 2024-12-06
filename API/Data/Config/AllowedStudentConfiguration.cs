using API.Entities;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;

public class AllowedStudentConfiguration : IEntityTypeConfiguration<AllowedStudent>
{
    public void Configure(EntityTypeBuilder<AllowedStudent> builder)
    {
        // Primary Key 
        builder.HasKey(x => x.Email);

        // Properties
        builder.Property(x => x.Email)
               .IsRequired()
               .HasMaxLength(100);

        builder.Property(x => x.Stage)
               .IsRequired()
               .HasMaxLength(50);

        builder.Property(x => x.StageLevel)
               .IsRequired();

        builder.Property(x => x.AccountActive)
               .IsRequired().HasDefaultValue(true);

        // Relationships
        builder.HasOne(x => x.Group)
               .WithMany(g => g.AllowedStudents)
               .HasForeignKey(x => x.GroupID)
               .OnDelete(DeleteBehavior.SetNull);

        
        builder.HasOne(x => x.Student) 
               .WithOne(s => s.AllowedStudent) 
               .HasForeignKey<Student>(x => x.Email) 
               .OnDelete(DeleteBehavior.Cascade); 
    }


}



