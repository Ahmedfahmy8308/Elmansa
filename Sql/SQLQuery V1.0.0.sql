CREATE TABLE [Groups] (
    [ID] int NOT NULL IDENTITY,
    [Name] nvarchar(100) NOT NULL,
    [Stage] nvarchar(50) NOT NULL,
    [StageLevel] int NOT NULL,
    [CreatedAt] datetime2 NOT NULL,
    [IsActive] bit NOT NULL DEFAULT CAST(1 AS bit),
    CONSTRAINT [PK_Groups] PRIMARY KEY ([ID])
);
GO


CREATE TABLE [Materials] (
    [ID] int NOT NULL IDENTITY,
    [Title] nvarchar(200) NOT NULL,
    [Type] nvarchar(50) NOT NULL,
    [FilePath] nvarchar(max) NOT NULL,
    [UploadDate] datetime2 NOT NULL,
    CONSTRAINT [PK_Materials] PRIMARY KEY ([ID])
);
GO


CREATE TABLE [AllowedStudents] (
    [Email] nvarchar(100) NOT NULL,
    [Stage] nvarchar(50) NOT NULL,
    [StageLevel] int NOT NULL,
    [GroupID] int NULL,
    [AccountActive] bit NOT NULL DEFAULT CAST(1 AS bit),
    CONSTRAINT [PK_AllowedStudents] PRIMARY KEY ([Email]),
    CONSTRAINT [FK_AllowedStudents_Groups_GroupID] FOREIGN KEY ([GroupID]) REFERENCES [Groups] ([ID]) ON DELETE SET NULL
);
GO


CREATE TABLE [Lessons] (
    [ID] int NOT NULL IDENTITY,
    [Title] nvarchar(200) NOT NULL,
    [Description] nvarchar(max) NOT NULL,
    [QRCode] nvarchar(max) NOT NULL,
    [StartDateTime] datetime2 NOT NULL,
    [EndDateTime] datetime2 NOT NULL,
    [GroubId] int NOT NULL,
    [IsAttendanceAllow] bit NOT NULL,
    CONSTRAINT [PK_Lessons] PRIMARY KEY ([ID]),
    CONSTRAINT [FK_Lessons_Groups_GroubId] FOREIGN KEY ([GroubId]) REFERENCES [Groups] ([ID]) ON DELETE CASCADE
);
GO


CREATE TABLE [Notifications] (
    [ID] int NOT NULL IDENTITY,
    [Title] nvarchar(200) NOT NULL,
    [NotificationContent] nvarchar(max) NOT NULL,
    [CreationDate] datetime2 NOT NULL,
    [Global] bit NOT NULL DEFAULT CAST(0 AS bit),
    [GroupId] int NULL,
    CONSTRAINT [PK_Notifications] PRIMARY KEY ([ID]),
    CONSTRAINT [FK_Notifications_Groups_GroupId] FOREIGN KEY ([GroupId]) REFERENCES [Groups] ([ID]) ON DELETE SET NULL
);
GO


CREATE TABLE [Quizs] (
    [ID] int NOT NULL IDENTITY,
    [Title] nvarchar(200) NOT NULL,
    [Description] nvarchar(max) NOT NULL,
    [CreationDate] datetime2 NOT NULL,
    [StartDate] datetime2 NOT NULL,
    [EndDate] datetime2 NOT NULL,
    [IsPublished] bit NOT NULL DEFAULT CAST(0 AS bit),
    [GroupId] int NULL,
    CONSTRAINT [PK_Quizs] PRIMARY KEY ([ID]),
    CONSTRAINT [FK_Quizs_Groups_GroupId] FOREIGN KEY ([GroupId]) REFERENCES [Groups] ([ID]) ON DELETE SET NULL
);
GO


CREATE TABLE [Students] (
    [ID] int NOT NULL IDENTITY,
    [Fname] nvarchar(50) NOT NULL,
    [Mname] nvarchar(50) NOT NULL,
    [Lname] nvarchar(50) NOT NULL,
    [Email] nvarchar(100) NOT NULL,
    [Stage] nvarchar(50) NOT NULL,
    [StageLevel] int NOT NULL,
    [DateOfBirth] datetime2 NOT NULL,
    [PhotoPath] nvarchar(max) NOT NULL,
    [Password] nvarchar(50) NOT NULL,
    [Number] nvarchar(11) NOT NULL,
    [SSN] nvarchar(14) NOT NULL,
    [GuardianNumber] nvarchar(11) NOT NULL,
    [GroupId] int NULL,
    CONSTRAINT [PK_Students] PRIMARY KEY ([ID]),
    CONSTRAINT [CK_Student_GuardianNumber_Length] CHECK (LEN(GuardianNumber) = 11),
    CONSTRAINT [CK_Student_Number_Length] CHECK (LEN(Number) = 11),
    CONSTRAINT [CK_Student_Number_NotEqual_GuardianNumber] CHECK (Number <> GuardianNumber),
    CONSTRAINT [CK_Student_SSN_Length] CHECK (LEN(SSN) = 14),
    CONSTRAINT [FK_Students_AllowedStudents_Email] FOREIGN KEY ([Email]) REFERENCES [AllowedStudents] ([Email]) ON DELETE CASCADE,
    CONSTRAINT [FK_Students_Groups_GroupId] FOREIGN KEY ([GroupId]) REFERENCES [Groups] ([ID]) ON DELETE SET NULL
);
GO


CREATE TABLE [Assignments] (
    [ID] int NOT NULL IDENTITY,
    [Title] nvarchar(200) NOT NULL,
    [Description] nvarchar(max) NOT NULL,
    [StartDate] datetime2 NOT NULL,
    [EndDate] datetime2 NOT NULL,
    [LessonID] int NOT NULL,
    CONSTRAINT [PK_Assignments] PRIMARY KEY ([ID]),
    CONSTRAINT [FK_Assignments_Lessons_LessonID] FOREIGN KEY ([LessonID]) REFERENCES [Lessons] ([ID]) ON DELETE CASCADE
);
GO


CREATE TABLE [LessonMaterials] (
    [LessonID] int NOT NULL,
    [MaterialID] int NOT NULL,
    CONSTRAINT [PK_LessonMaterials] PRIMARY KEY ([LessonID], [MaterialID]),
    CONSTRAINT [FK_LessonMaterials_Lessons_LessonID] FOREIGN KEY ([LessonID]) REFERENCES [Lessons] ([ID]) ON DELETE CASCADE,
    CONSTRAINT [FK_LessonMaterials_Materials_MaterialID] FOREIGN KEY ([MaterialID]) REFERENCES [Materials] ([ID]) ON DELETE CASCADE
);
GO


CREATE TABLE [QuizQuestions] (
    [ID] int NOT NULL IDENTITY,
    [QuizId] int NOT NULL,
    [Text] nvarchar(max) NOT NULL,
    [CorrectAnswer] nvarchar(max) NOT NULL,
    CONSTRAINT [PK_QuizQuestions] PRIMARY KEY ([ID]),
    CONSTRAINT [FK_QuizQuestions_Quizs_QuizId] FOREIGN KEY ([QuizId]) REFERENCES [Quizs] ([ID]) ON DELETE CASCADE
);
GO


CREATE TABLE [Attendances] (
    [ID] int NOT NULL IDENTITY,
    [StudentId] int NOT NULL,
    [LessonId] int NOT NULL,
    CONSTRAINT [PK_Attendances] PRIMARY KEY ([ID]),
    CONSTRAINT [FK_Attendances_Lessons_LessonId] FOREIGN KEY ([LessonId]) REFERENCES [Lessons] ([ID]) ON DELETE CASCADE,
    CONSTRAINT [FK_Attendances_Students_StudentId] FOREIGN KEY ([StudentId]) REFERENCES [Students] ([ID]) ON DELETE CASCADE
);
GO


CREATE TABLE [QuizSubmissions] (
    [ID] int NOT NULL IDENTITY,
    [StudentID] int NOT NULL,
    [QuizID] int NOT NULL,
    [Score] float NULL,
    [SubmissionDate] datetime2 NOT NULL,
    [Answers] nvarchar(max) NOT NULL,
    CONSTRAINT [PK_QuizSubmissions] PRIMARY KEY ([ID]),
    CONSTRAINT [FK_QuizSubmissions_Quizs_QuizID] FOREIGN KEY ([QuizID]) REFERENCES [Quizs] ([ID]) ON DELETE CASCADE,
    CONSTRAINT [FK_QuizSubmissions_Students_StudentID] FOREIGN KEY ([StudentID]) REFERENCES [Students] ([ID]) ON DELETE CASCADE
);
GO


CREATE TABLE [UserNotifications] (
    [ID] int NOT NULL IDENTITY,
    [NotificationId] int NOT NULL,
    [StudentID] int NOT NULL,
    [IsRead] bit NOT NULL DEFAULT CAST(0 AS bit),
    [ReadAt] datetime2 NULL,
    CONSTRAINT [PK_UserNotifications] PRIMARY KEY ([ID]),
    CONSTRAINT [FK_UserNotifications_Notifications_NotificationId] FOREIGN KEY ([NotificationId]) REFERENCES [Notifications] ([ID]) ON DELETE CASCADE,
    CONSTRAINT [FK_UserNotifications_Students_StudentID] FOREIGN KEY ([StudentID]) REFERENCES [Students] ([ID]) ON DELETE CASCADE
);
GO


CREATE TABLE [AssignmentSubmissions] (
    [ID] int NOT NULL IDENTITY,
    [StudentID] int NOT NULL,
    [AssignmentID] int NOT NULL,
    [FilePath] nvarchar(max) NOT NULL,
    [SubmissionDate] datetime2 NOT NULL,
    [Grade] float NULL,
    CONSTRAINT [PK_AssignmentSubmissions] PRIMARY KEY ([ID]),
    CONSTRAINT [FK_AssignmentSubmissions_Assignments_AssignmentID] FOREIGN KEY ([AssignmentID]) REFERENCES [Assignments] ([ID]) ON DELETE CASCADE,
    CONSTRAINT [FK_AssignmentSubmissions_Students_StudentID] FOREIGN KEY ([StudentID]) REFERENCES [Students] ([ID]) ON DELETE CASCADE
);
GO


CREATE TABLE [QuizOptions] (
    [ID] int NOT NULL IDENTITY,
    [QuestionId] int NOT NULL,
    [OptionText] nvarchar(max) NOT NULL,
    [IsCorrect] bit NOT NULL DEFAULT CAST(0 AS bit),
    CONSTRAINT [PK_QuizOptions] PRIMARY KEY ([ID]),
    CONSTRAINT [FK_QuizOptions_QuizQuestions_QuestionId] FOREIGN KEY ([QuestionId]) REFERENCES [QuizQuestions] ([ID]) ON DELETE CASCADE
);
GO


CREATE INDEX [IX_AllowedStudents_GroupID] ON [AllowedStudents] ([GroupID]);
GO


CREATE INDEX [IX_Assignments_LessonID] ON [Assignments] ([LessonID]);
GO


CREATE INDEX [IX_AssignmentSubmissions_AssignmentID] ON [AssignmentSubmissions] ([AssignmentID]);
GO


CREATE INDEX [IX_AssignmentSubmissions_StudentID] ON [AssignmentSubmissions] ([StudentID]);
GO


CREATE INDEX [IX_Attendances_LessonId] ON [Attendances] ([LessonId]);
GO


CREATE INDEX [IX_Attendances_StudentId] ON [Attendances] ([StudentId]);
GO


CREATE INDEX [IX_LessonMaterials_MaterialID] ON [LessonMaterials] ([MaterialID]);
GO


CREATE INDEX [IX_Lessons_GroubId] ON [Lessons] ([GroubId]);
GO


CREATE INDEX [IX_Notifications_GroupId] ON [Notifications] ([GroupId]);
GO


CREATE INDEX [IX_QuizOptions_QuestionId] ON [QuizOptions] ([QuestionId]);
GO


CREATE INDEX [IX_QuizQuestions_QuizId] ON [QuizQuestions] ([QuizId]);
GO


CREATE INDEX [IX_Quizs_GroupId] ON [Quizs] ([GroupId]);
GO


CREATE INDEX [IX_QuizSubmissions_QuizID] ON [QuizSubmissions] ([QuizID]);
GO


CREATE INDEX [IX_QuizSubmissions_StudentID] ON [QuizSubmissions] ([StudentID]);
GO


CREATE UNIQUE INDEX [IX_Students_Email] ON [Students] ([Email]);
GO


CREATE INDEX [IX_Students_GroupId] ON [Students] ([GroupId]);
GO


CREATE UNIQUE INDEX [IX_Students_SSN] ON [Students] ([SSN]);
GO


CREATE INDEX [IX_UserNotifications_NotificationId] ON [UserNotifications] ([NotificationId]);
GO


CREATE INDEX [IX_UserNotifications_StudentID] ON [UserNotifications] ([StudentID]);
GO
