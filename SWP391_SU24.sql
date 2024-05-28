USE master;

IF EXISTS
(
    SELECT name
    FROM master.dbo.sysdatabases
    WHERE name = N'SWP391_SU24'
)
BEGIN
    ALTER DATABASE [SWP391_SU24] SET OFFLINE WITH ROLLBACK IMMEDIATE;
    ALTER DATABASE [SWP391_SU24] SET ONLINE;
    DROP DATABASE [SWP391_SU24];
END;
GO

CREATE DATABASE SWP391_SU24;
GO

USE [SWP391_SU24];
GO
CREATE TABLE Categories
(
    CategoryID INT IDENTITY(1, 1) PRIMARY KEY,
    [CategoryDescription] NVARCHAR(69) NOT NULL,
);
GO
CREATE TABLE Semesters
(
    SemesterID INT IDENTITY(1, 1) PRIMARY KEY,
    [SemesterDescription] NVARCHAR(69) NOT NULL,
);
GO
CREATE TABLE Courses
(
    CourseID INT IDENTITY(1, 1) PRIMARY KEY,
    [CourseBannerImage] VARCHAR(420),
    [Title] NVARCHAR(69) NOT NULL,
    [CourseDescription] NTEXT NOT NULL,
    PublishDate DATE
        DEFAULT NULL,
    Lecturer NVARCHAR(69) NOT NULL,
    SemesterID INT
        FOREIGN KEY REFERENCES dbo.Semesters (SemesterID),
    CategoryID INT
        FOREIGN KEY REFERENCES dbo.Categories (CategoryID),
);
GO

CREATE TABLE Exams
(
    ExamID INT IDENTITY(1, 1) PRIMARY KEY,
    ExamName NVARCHAR(420),
    CourseID INT
        FOREIGN KEY REFERENCES dbo.Courses (CourseID) ON DELETE CASCADE,
    Duration TIME NOT NULL,
);
GO
CREATE TABLE Questions
(
    QuestionID INT IDENTITY(1, 1) PRIMARY KEY,
    QuestionDetail NVARCHAR(1000) NOT NULL,
    ExamID INT
        FOREIGN KEY REFERENCES dbo.Exams (ExamID) ON DELETE CASCADE
);
GO
CREATE TABLE Choices
(
    ChoiceID INT IDENTITY(1, 1) PRIMARY KEY,
    QuestionID INT
        FOREIGN KEY REFERENCES dbo.Questions (QuestionID) ON DELETE CASCADE,
    Description NVARCHAR(420),
    IsTrueAnswer BIT
        DEFAULT 0,
);
GO
CREATE TABLE [Users]
(
    UserID INT IDENTITY(1, 1) PRIMARY KEY,
    UserName NVARCHAR(420) NOT NULL,
    Email VARCHAR(420) NOT NULL,
    Password VARCHAR(69) NOT NULL,
    Role INT CHECK (Role IN ( 1, 2, 3 , 4)) NOT NULL, /*1: User
														2: Teacher
														3: Manager
														4: Admin*/
    DOB DATE,
    Gender BIT,
    PhoneNumber VARCHAR(69),

    RestrictedUntil DATETIME DEFAULT '2000-01-01 00:00:00',
    RestrictedReason NVARCHAR(420) NULL,
);
GO

CREATE TABLE ExamPapers
(
    PaperID INT IDENTITY(1, 1) PRIMARY KEY,
    UserID INT
        FOREIGN KEY REFERENCES dbo.[Users] (UserID) ON DELETE CASCADE,
    ExamID INT
        FOREIGN KEY REFERENCES dbo.Exams (ExamID) ON DELETE CASCADE,
    TimeStart DATETIME
        DEFAULT GETDATE(),
    TimeEnd DATETIME,
    State INT CHECK (State IN ( 1, 2 )),
    Score INT
);
GO
CREATE TABLE UserAnswers
(
    AnswerID INT IDENTITY(1, 1),
    PaperID INT
        FOREIGN KEY REFERENCES dbo.ExamPapers (PaperID) ON DELETE CASCADE,
    ChoiceID INT
        FOREIGN KEY REFERENCES dbo.Choices (ChoiceID),
    PRIMARY KEY (
                    AnswerID,
                    ChoiceID
                )
);
GO

CREATE TABLE CourseAssignment (
  UserId INT,
  CourseId INT,
  PRIMARY KEY (UserId, CourseId),
  FOREIGN KEY (UserId) REFERENCES Users(UserID) ON DELETE CASCADE,
  FOREIGN KEY (CourseId) REFERENCES Courses(CourseID)ON DELETE CASCADE,
);

GO
INSERT [dbo].[Categories] ([CategoryDescription]) VALUES (N'Programing')
INSERT [dbo].[Categories] ([CategoryDescription]) VALUES (N'Design')
INSERT [dbo].[Categories] ([CategoryDescription]) VALUES (N'Marketing')
GO 

INSERT [dbo].[Semesters] ([SemesterDescription]) VALUES (N'SUMMER 2024')
INSERT [dbo].[Semesters] ([SemesterDescription]) VALUES (N'SPRING 2024')
INSERT [dbo].[Semesters] ([SemesterDescription]) VALUES (N'FALL 2023')
GO
INSERT [dbo].[Courses] ([CourseBannerImage], [Title], [CourseDescription], [PublishDate], [Lecturer], [SemesterID], [CategoryID]) VALUES (N'https://www.classcentral.com/report/wp-content/uploads/2022/05/Java-BCG-Banner.png',  N'SWP391',N'Application development project', CAST(N'2023-06-16' AS Date), N'Bùi Đình Chiến (FSE HN - Giảng viên CF)', 1, 1)
INSERT [dbo].[Courses] ([CourseBannerImage], [Title], [CourseDescription], [PublishDate], [Lecturer], [SemesterID], [CategoryID]) VALUES (N'https://www.freecodecamp.org/news/content/images/size/w2000/2022/02/Banner-10.png', N'PRJ301', N'Java Web Application Development', CAST(N'2023-01-01' AS Date), N'Bùi Ngọc Anh (FSE HN - Giảng viên CF)', 1, 1)
INSERT [dbo].[Courses] ([CourseBannerImage], [Title], [CourseDescription], [PublishDate], [Lecturer], [SemesterID], [CategoryID]) VALUES (N'https://www.freecodecamp.org/news/content/images/size/w2000/2022/02/Banner-10.png', N'ACC101', N'Principles of Accounting', CAST(N'2023-11-05' AS Date), N'Phan Trường Lâm (FSE HN - Giảng viên CF)', 3, 1)
INSERT [dbo].[Courses] ([CourseBannerImage], [Title], [CourseDescription], [PublishDate], [Lecturer], [SemesterID], [CategoryID]) VALUES (N'https://www.freecodecamp.org/news/content/images/size/w2000/2022/02/Banner-10.png', N'MAS202', N'Applied Statistics for Business', CAST(N'2022-03-07' AS Date), N'Thành Trung Đinh', 1, 2)
INSERT [dbo].[Courses] ([CourseBannerImage], [Title], [CourseDescription], [PublishDate], [Lecturer], [SemesterID], [CategoryID]) VALUES (N'https://www.freecodecamp.org/news/content/images/size/w2000/2022/02/Banner-10.png', N'FIN201', N'Monetary Economics and Global Economy', CAST(N'2022-10-12' AS Date), N'Nguyễn Minh Hải (FSB HN)', 3, 2)
INSERT [dbo].[Courses] ([CourseBannerImage], [Title], [CourseDescription], [PublishDate], [Lecturer], [SemesterID], [CategoryID]) VALUES (N'https://www.freecodecamp.org/news/content/images/size/w2000/2022/02/Banner-10.png', N'TPG203', N'Basic typography & Layout', CAST(N'2022-10-12' AS Date), N'Bùi Ngọc Anh (FSE HN - Giảng viên CF)', 2, 2)
INSERT [dbo].[Courses] ([CourseBannerImage], [Title], [CourseDescription], [PublishDate], [Lecturer], [SemesterID], [CategoryID]) VALUES (N'https://www.freecodecamp.org/news/content/images/size/w2000/2022/02/Banner-10.png', N'DTG102', N'Visual Design Tools', CAST(N'2022-10-05' AS Date), N'Bùi Ngọc Anh (FSE HN - Giảng viên CF)', 3, 3)
INSERT [dbo].[Courses] ([CourseBannerImage], [Title], [CourseDescription], [PublishDate], [Lecturer], [SemesterID], [CategoryID]) VALUES (N'https://www.freecodecamp.org/news/content/images/size/w2000/2022/02/Banner-10.png', N'ENM301', N'BUSINESS ENGLISH - Level: Intermediate', CAST(N'2022-11-11' AS Date), N'Nguyễn Thị Quỳnh Hoa (FSE HN - Giảng viên Tiếng Anh)', 3, 3)
INSERT [dbo].[Courses] ([CourseBannerImage], [Title], [CourseDescription], [PublishDate], [Lecturer], [SemesterID], [CategoryID]) VALUES (N'https://www.freecodecamp.org/news/content/images/size/w2000/2022/02/Banner-10.png', N'DBI202', N'Introduction to Database ', CAST(N'2022-10-11' AS Date), N' Bùi Ngọc Anh (FSE HN - Giảng viên CF)', 1, 3)
GO

-- Generate default accounts
-- Pass: 12345678
insert into Users(Username, Email, Password, Role)
values ('admin', 'admin@gmail.com', '6a5aeb1ea832832a9969a562357994ba', 4)

insert into Users(Username, Email, Password, Role)
values ('manager', 'manager@gmail.com', '6a5aeb1ea832832a9969a562357994ba', 3)

insert into Users(Username, Email, Password, Role)
values ('teacher', 'teacher@gmail.com', '6a5aeb1ea832832a9969a562357994ba', 2)

insert into Users(Username, Email, Password, Role)
values ('user', 'user@gmail.com', '6a5aeb1ea832832a9969a562357994ba', 1)

INSERT INTO dbo.Exams(ExamName, CourseID, Duration)VALUES( N'Module 1 Exam', 1, '00:30:00')

INSERT INTO dbo.Questions(QuestionDetail, ExamID)VALUES(   N'Which of the following is not an element of descriptive statistical problems?', 1)
INSERT INTO dbo.Questions(QuestionDetail, ExamID)VALUES(   N'A bag of colored candies contains 20 red, 25 yellow, 15 blue and 20 orange candies. An experiment consists of randomly choosing one candy from the bag and recording its color. What is the sample space for this experiment?', 1)
INSERT INTO dbo.Questions(QuestionDetail, ExamID)VALUES(   N'Sixty-five percent of men consider themselves knowledgeable football fans. If 15 men are randomly selected, find the probability that exactly five of them will consider themselves knowledgeable fans.', 1)
INSERT INTO dbo.Questions(QuestionDetail, ExamID)VALUES(   N'The conditional probability of event G, given the knowledge that event H has occurred, would be written as _____.', 1)
INSERT INTO dbo.Questions(QuestionDetail, ExamID)VALUES(   N'A company has 2 machines that produce widgets. An older machine produces 23% defective widgets, while the new machine produces only 8% defective widgets. In addition, the new machine produces 3 times as many widgets as the older machine does. Given that a widget was produced by the new machine, what is the probability it is not defective?', 1)
INSERT INTO dbo.Questions(QuestionDetail, ExamID)VALUES(   N'If P(A) = 0.45, P(B) = 0.25, and P(B|A) = 0.45, are A and B independent?', 1)
INSERT INTO dbo.Questions(QuestionDetail, ExamID)VALUES(   N'It was found that 60% of the workers were white, 30% were black and 10% are other races. Given that a worker was white, the probability that the worker had claimed bias was 30%. Given that a worker was black, the probability that the worker had claimed bias was 40%. Given that a worker was other race, the probability that the worker had claimed bias was 0%. If a randomly selected worker had claimed bias, what is the probability that the worker is white?', 1)
INSERT INTO dbo.Questions(QuestionDetail, ExamID)VALUES(   N'Samples of 10 parts from a metal punching process are selected every hour. Let X denote the number of parts in the sample of 10 that require rework. If the percentage of parts that require rework at 3%, what is the probability that X exceeds 2?', 1)
INSERT INTO dbo.Questions(QuestionDetail, ExamID)VALUES(   N'The range of the random variable X is {1, 2, 3, 6, u}, where u is unknown. If each value is equally likely and the mean of X is 10, determine the value of u.', 1)
INSERT INTO dbo.Questions(QuestionDetail, ExamID)VALUES(   N'The probability that a radish seed will germinate is 0.26. A gardener plants seeds in batches of 52. Find the standard deviation for the random variable X, the number of seeds germinating in each batch.', 1)

INSERT INTO dbo.Choices(QuestionID, Description, IsTrueAnswer)VALUES(1, N'a. The population or sample of interest.', 0)
INSERT INTO dbo.Choices(QuestionID, Description, IsTrueAnswer)VALUES(1, N'b. Identification of patterns in the data.', 0)
INSERT INTO dbo.Choices(QuestionID, Description, IsTrueAnswer)VALUES(1, N'c. An inference made about the population based on the sample.', 1)
INSERT INTO dbo.Choices(QuestionID, Description, IsTrueAnswer)VALUES(1, N'd. Tables, graphs, or numerical summary tools.', 0)

INSERT INTO dbo.Choices(QuestionID, Description, IsTrueAnswer)VALUES(2, N'a. {80}', 0)
INSERT INTO dbo.Choices(QuestionID, Description, IsTrueAnswer)VALUES(2, N'b. {20, 25, 15, 20}', 0)
INSERT INTO dbo.Choices(QuestionID, Description, IsTrueAnswer)VALUES(2, N'c. {red, yellow, blue, orange}', 1)
INSERT INTO dbo.Choices(QuestionID, Description, IsTrueAnswer)VALUES(2, N'd. {1/4, 5/16, 7/16}', 0)
INSERT INTO dbo.Choices(QuestionID, Description, IsTrueAnswer)VALUES(2, N'e. {red, yellow, orange}', 0)

INSERT INTO dbo.Choices(QuestionID, Description, IsTrueAnswer)VALUES(3, N'a. 0.0096', 1)
INSERT INTO dbo.Choices(QuestionID, Description, IsTrueAnswer)VALUES(3, N'b. 0.6541', 0)
INSERT INTO dbo.Choices(QuestionID, Description, IsTrueAnswer)VALUES(3, N'c. 0.3853', 0)
INSERT INTO dbo.Choices(QuestionID, Description, IsTrueAnswer)VALUES(3, N'd. 0.0341', 0)

INSERT INTO dbo.Choices(QuestionID, Description, IsTrueAnswer)VALUES(4, N'a. P(H | G)', 0)
INSERT INTO dbo.Choices(QuestionID, Description, IsTrueAnswer)VALUES(4, N'b. P(G)', 0)
INSERT INTO dbo.Choices(QuestionID, Description, IsTrueAnswer)VALUES(4, N'c. P(H)', 0)
INSERT INTO dbo.Choices(QuestionID, Description, IsTrueAnswer)VALUES(4, N'd. P(G | H)', 1)

INSERT INTO dbo.Choices(QuestionID, Description, IsTrueAnswer)VALUES(5, N'a. 0.92', 1)
INSERT INTO dbo.Choices(QuestionID, Description, IsTrueAnswer)VALUES(5, N'b. 0.06', 0)
INSERT INTO dbo.Choices(QuestionID, Description, IsTrueAnswer)VALUES(5, N'c. 0.94', 0)
INSERT INTO dbo.Choices(QuestionID, Description, IsTrueAnswer)VALUES(5, N'd. 0.50', 0)

INSERT INTO dbo.Choices(QuestionID, Description, IsTrueAnswer)VALUES(6, N'a. cannot determine', 0)
INSERT INTO dbo.Choices(QuestionID, Description, IsTrueAnswer)VALUES(6, N'b. yes', 0)
INSERT INTO dbo.Choices(QuestionID, Description, IsTrueAnswer)VALUES(6, N'c. no', 1)

INSERT INTO dbo.Choices(QuestionID, Description, IsTrueAnswer)VALUES(7, N'a. 0.3', 0)
INSERT INTO dbo.Choices(QuestionID, Description, IsTrueAnswer)VALUES(7, N'b. 0.7', 0)
INSERT INTO dbo.Choices(QuestionID, Description, IsTrueAnswer)VALUES(7, N'c. 0.6', 1)
INSERT INTO dbo.Choices(QuestionID, Description, IsTrueAnswer)VALUES(7, N'd. 0.4', 0)

INSERT INTO dbo.Choices(QuestionID, Description, IsTrueAnswer)VALUES(8, N'a. 0.3152', 0)
INSERT INTO dbo.Choices(QuestionID, Description, IsTrueAnswer)VALUES(8, N'b. 0.0028', 1)
INSERT INTO dbo.Choices(QuestionID, Description, IsTrueAnswer)VALUES(8, N'c. 0.4114', 0)
INSERT INTO dbo.Choices(QuestionID, Description, IsTrueAnswer)VALUES(8, N'd. 0.0159', 0)

INSERT INTO dbo.Choices(QuestionID, Description, IsTrueAnswer)VALUES(9, N'a. 24', 0)
INSERT INTO dbo.Choices(QuestionID, Description, IsTrueAnswer)VALUES(9, N'b. 38', 1)
INSERT INTO dbo.Choices(QuestionID, Description, IsTrueAnswer)VALUES(9, N'c. 19', 0)
INSERT INTO dbo.Choices(QuestionID, Description, IsTrueAnswer)VALUES(9, N'd. 12', 0)

INSERT INTO dbo.Choices(QuestionID, Description, IsTrueAnswer)VALUES(10, N'a. 3.25', 0)
INSERT INTO dbo.Choices(QuestionID, Description, IsTrueAnswer)VALUES(10, N'b. 1.77', 0)
INSERT INTO dbo.Choices(QuestionID, Description, IsTrueAnswer)VALUES(10, N'c. 1.52', 0)
INSERT INTO dbo.Choices(QuestionID, Description, IsTrueAnswer)VALUES(10, N'd. 3.16', 1)
