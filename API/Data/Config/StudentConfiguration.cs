using API.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace API.Data.Config
{
    public class StudentConfiguration : IEntityTypeConfiguration<Student>
    {
        public void Configure(EntityTypeBuilder<Student> builder)
        {
            // Primary Key 
            builder.HasKey(x => x.ID);
            

            // Properties
            builder.Property(x => x.Fname).IsRequired().HasMaxLength(50);
            builder.Property(x => x.Mname).IsRequired().HasMaxLength(50);
            builder.Property(x => x.Lname).IsRequired().HasMaxLength(50);
            builder.Property(x => x.Email).IsRequired().HasMaxLength(100);
            builder.Property(x => x.Stage).IsRequired().HasMaxLength(50);
            builder.Property(x => x.StageLevel).IsRequired();
            builder.Property(x => x.DateOfBirth).IsRequired(); 
            builder.Property(x => x.PhotoPath).IsRequired();
            builder.Property(x => x.Password).IsRequired().HasMaxLength(50);
            builder.Property(x => x.Number).IsRequired().HasMaxLength(11); 
            builder.Property(x => x.SSN).IsRequired().HasMaxLength(14); 
            builder.Property(x => x.GuardianNumber).IsRequired().HasMaxLength(11); 


            // Adding the check constraint 
            builder.ToTable(t =>
            {
                t.HasCheckConstraint("CK_Student_SSN_Length", "LEN(SSN) = 14");
                t.HasCheckConstraint("CK_Student_Number_Length", "LEN(Number) = 11");
                t.HasCheckConstraint("CK_Student_GuardianNumber_Length", "LEN(GuardianNumber) = 11");
                t.HasCheckConstraint("CK_Student_Number_NotEqual_GuardianNumber", "Number <> GuardianNumber");

            });

            // Indexes unique

            builder.HasIndex(x => x.Email).IsUnique();
            builder.HasIndex(x => x.SSN).IsUnique();

            // Relationships
            builder.HasOne(x => x.Group)
                   .WithMany(g => g.Students)
                   .HasForeignKey(x => x.GroupId)
                   .OnDelete(DeleteBehavior.SetNull);

            builder.HasOne(x => x.AllowedStudent)
                   .WithOne(a => a.Student)
                   .HasForeignKey<Student>(x => x.Email)
                   .OnDelete(DeleteBehavior.Cascade);

            builder.HasMany(x => x.Attendances)
                   .WithOne(a => a.Student)
                   .HasForeignKey(a => a.StudentId)
                   .OnDelete(DeleteBehavior.Cascade);

            builder.HasMany(x => x.UserNotifications)
                   .WithOne(u => u.Student)
                   .HasForeignKey(u => u.StudentID)
                   .OnDelete(DeleteBehavior.Cascade);

            builder.HasMany(x => x.QuizSubmissions)
                   .WithOne(q => q.Student)
                   .HasForeignKey(q => q.StudentID)
                   .OnDelete(DeleteBehavior.Cascade);

            builder.HasMany(x => x.AssignmentSubmissions)
                   .WithOne(a => a.Student)
                   .HasForeignKey(a => a.StudentID)
                   .OnDelete(DeleteBehavior.Cascade);
        }
    }
}
