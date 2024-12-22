namespace API.Entities;

public class GroupQuiz
{
    public int GroupID { get; set; }
    public string QuizID { get; set; } = null!;

    public Group Group { get; set; } = null!;
    public Quiz Quiz { get; set; } = null!;
}

