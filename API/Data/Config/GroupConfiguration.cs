using API.Entities;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;

public class GroupConfiguration : IEntityTypeConfiguration<Group>
{
    public void Configure(EntityTypeBuilder<Group> builder)
    {
        // Primary Key
        builder.HasKey(g => g.ID);
        builder.Property(x => x.ID)
                   .ValueGeneratedOnAdd();

        // Properties
        builder.Property(g => g.Name)
               .IsRequired()
               .HasMaxLength(100);

        builder.Property(g => g.Stage)
               .IsRequired()
               .HasMaxLength(50);

        builder.Property(g => g.StageLevel)
               .IsRequired();

        builder.Property(g => g.CreatedAt)
               .IsRequired()
               .HasColumnType("datetime2(0)");

        builder.Property(g => g.IsActive)
               .IsRequired().HasDefaultValue(true);

        // Relationships
        builder.HasMany(g => g.Students)
               .WithOne(s => s.Group)
               .HasForeignKey(s => s.GroupId)
               .OnDelete(DeleteBehavior.SetNull);

        builder.HasMany(g => g.AllowedStudents)
               .WithOne(a => a.Group)
               .HasForeignKey(a => a.GroupID)
               .OnDelete(DeleteBehavior.SetNull);

        //builder.HasMany(g => g.Quizzes)
        //       .WithOne(q => q.Group)
        //       .HasForeignKey(q => q.QuizID)
        //       .OnDelete(DeleteBehavior.Cascade);

        builder.HasMany(g => g.Notifications)
               .WithOne(n => n.Group)
               .HasForeignKey(n => n.GroupId)
               .OnDelete(DeleteBehavior.SetNull);

    }
}



