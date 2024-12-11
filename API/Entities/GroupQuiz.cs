namespace API.Entities;

public class GroupQuiz
{
    public int GroupID { get; set; }
    public int QuizID { get; set; }

    public Group Group { get; set; } = null!;
    public Quiz Quiz { get; set; } = null!;
}

