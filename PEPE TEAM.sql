
USE [master]
GO
/****** Object:  Database [SWP391_SU24]    Script Date: 6/5/2024 8:37:45 PM ******/
CREATE DATABASE [SWP391_SU24]

ALTER DATABASE [SWP391_SU24] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SWP391_SU24].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SWP391_SU24] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SWP391_SU24] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SWP391_SU24] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SWP391_SU24] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SWP391_SU24] SET ARITHABORT OFF 
GO
ALTER DATABASE [SWP391_SU24] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SWP391_SU24] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SWP391_SU24] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SWP391_SU24] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SWP391_SU24] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SWP391_SU24] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SWP391_SU24] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SWP391_SU24] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SWP391_SU24] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SWP391_SU24] SET  ENABLE_BROKER 
GO
ALTER DATABASE [SWP391_SU24] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SWP391_SU24] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SWP391_SU24] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SWP391_SU24] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SWP391_SU24] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SWP391_SU24] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SWP391_SU24] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SWP391_SU24] SET RECOVERY FULL 
GO
ALTER DATABASE [SWP391_SU24] SET  MULTI_USER 
GO
ALTER DATABASE [SWP391_SU24] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SWP391_SU24] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SWP391_SU24] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SWP391_SU24] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [SWP391_SU24] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [SWP391_SU24] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'SWP391_SU24', N'ON'
GO
ALTER DATABASE [SWP391_SU24] SET QUERY_STORE = OFF
GO
USE [SWP391_SU24]
GO
/****** Object:  Table [dbo].[Choices]    Script Date: 6/5/2024 8:37:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Choices](
	[ChoiceID] [int] IDENTITY(1,1) NOT NULL,
	[QuestionID] [int] NULL,
	[Description] [nvarchar](420) NULL,
	[IsTrueAnswer] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[ChoiceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CourseAssignment]    Script Date: 6/5/2024 8:37:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CourseAssignment](
	[UserId] [int] NOT NULL,
	[CourseId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[CourseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Courses]    Script Date: 6/5/2024 8:37:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Courses](
	[CourseID] [int] IDENTITY(1,1) NOT NULL,
	[CourseBannerImage] [varchar](420) NULL,
	[Title] [nvarchar](69) NOT NULL,
	[CourseDescription] [ntext] NOT NULL,
	[PublishDate] [date] NULL,
	[Lecturer] [nvarchar](69) NOT NULL,
	[SemesterID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[CourseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Semesters]    Script Date: 6/5/2024 8:37:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Semesters](
	[SemesterID] [int] IDENTITY(1,1) NOT NULL,
	[SemesterDescription] [nvarchar](69) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[SemesterID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Class] (
    [ClassID] INT IDENTITY(1,1) NOT NULL,
    [ClassName] NVARCHAR(69) NOT NULL,
    [SemesterID] INT NOT NULL, -- Foreign key to link with Semesters
    PRIMARY KEY CLUSTERED ([ClassID] ASC),
    FOREIGN KEY ([SemesterID]) REFERENCES [dbo].Semesters
)
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClassCourses] (
    [ClassID] [int] IDENTITY(1,1) NOT NULL,
    [CourseID] INT NOT NULL,
    PRIMARY KEY CLUSTERED ([ClassID], [CourseID]),
    FOREIGN KEY ([ClassID]) REFERENCES [dbo].Class,
    FOREIGN KEY ([CourseID]) REFERENCES [dbo].Courses
);
/****** Object:  Table [dbo].[ExamPapers]    Script Date: 6/5/2024 8:37:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ExamPapers](
	[PaperID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NULL,
	[ExamID] [int] NULL,
	[TimeStart] [datetime] NULL,
	[TimeEnd] [datetime] NULL,
	[State] [int] NULL,
	[Score] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[PaperID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Exams]    Script Date: 6/5/2024 8:37:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Exams](
	[ExamID] [int] IDENTITY(1,1) NOT NULL,
	[ExamName] [nvarchar](420) NULL,
	[CourseID] [int] NULL,
	[Duration] [time](7) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ExamID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Questions]    Script Date: 6/5/2024 8:37:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Questions](
	[QuestionID] [int] IDENTITY(1,1) NOT NULL,
	[QuestionDetail] [nvarchar](1000) NOT NULL,
	[ExamID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[QuestionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[UserAnswers]    Script Date: 6/5/2024 8:37:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserAnswers](
	[AnswerID] [int] IDENTITY(1,1) NOT NULL,
	[PaperID] [int] NULL,
	[ChoiceID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[AnswerID] ASC,
	[ChoiceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 6/5/2024 8:37:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](420) NOT NULL,
	[Email] [varchar](420) NOT NULL,
	[Role] [int] NOT NULL,
	[DOB] [date] NULL,
	[Gender] [bit] NULL,
	[PhoneNumber] [varchar](69) NULL,
	[RestrictedUntil] [datetime] NULL,
	[RestrictedReason] [nvarchar](420) NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Choices] ON 
GO
INSERT [dbo].[Choices] ([ChoiceID], [QuestionID], [Description], [IsTrueAnswer]) VALUES (1, 1, N'a. The population or sample of interest.', 0)
GO
INSERT [dbo].[Choices] ([ChoiceID], [QuestionID], [Description], [IsTrueAnswer]) VALUES (2, 1, N'b. Identification of patterns in the data.', 0)
GO
INSERT [dbo].[Choices] ([ChoiceID], [QuestionID], [Description], [IsTrueAnswer]) VALUES (3, 1, N'c. An inference made about the population based on the sample.', 1)
GO
INSERT [dbo].[Choices] ([ChoiceID], [QuestionID], [Description], [IsTrueAnswer]) VALUES (4, 1, N'd. Tables, graphs, or numerical summary tools.', 0)
GO
INSERT [dbo].[Choices] ([ChoiceID], [QuestionID], [Description], [IsTrueAnswer]) VALUES (5, 2, N'a. {80}', 0)
GO
INSERT [dbo].[Choices] ([ChoiceID], [QuestionID], [Description], [IsTrueAnswer]) VALUES (6, 2, N'b. {20, 25, 15, 20}', 0)
GO
INSERT [dbo].[Choices] ([ChoiceID], [QuestionID], [Description], [IsTrueAnswer]) VALUES (7, 2, N'c. {red, yellow, blue, orange}', 1)
GO
INSERT [dbo].[Choices] ([ChoiceID], [QuestionID], [Description], [IsTrueAnswer]) VALUES (8, 2, N'd. {1/4, 5/16, 7/16}', 0)
GO
INSERT [dbo].[Choices] ([ChoiceID], [QuestionID], [Description], [IsTrueAnswer]) VALUES (9, 2, N'e. {red, yellow, orange}', 0)
GO
INSERT [dbo].[Choices] ([ChoiceID], [QuestionID], [Description], [IsTrueAnswer]) VALUES (10, 3, N'a. 0.0096', 1)
GO
INSERT [dbo].[Choices] ([ChoiceID], [QuestionID], [Description], [IsTrueAnswer]) VALUES (11, 3, N'b. 0.6541', 0)
GO
INSERT [dbo].[Choices] ([ChoiceID], [QuestionID], [Description], [IsTrueAnswer]) VALUES (12, 3, N'c. 0.3853', 0)
GO
INSERT [dbo].[Choices] ([ChoiceID], [QuestionID], [Description], [IsTrueAnswer]) VALUES (13, 3, N'd. 0.0341', 0)
GO
INSERT [dbo].[Choices] ([ChoiceID], [QuestionID], [Description], [IsTrueAnswer]) VALUES (14, 4, N'a. P(H | G)', 0)
GO
INSERT [dbo].[Choices] ([ChoiceID], [QuestionID], [Description], [IsTrueAnswer]) VALUES (15, 4, N'b. P(G)', 0)
GO
INSERT [dbo].[Choices] ([ChoiceID], [QuestionID], [Description], [IsTrueAnswer]) VALUES (16, 4, N'c. P(H)', 0)
GO
INSERT [dbo].[Choices] ([ChoiceID], [QuestionID], [Description], [IsTrueAnswer]) VALUES (17, 4, N'd. P(G | H)', 1)
GO
INSERT [dbo].[Choices] ([ChoiceID], [QuestionID], [Description], [IsTrueAnswer]) VALUES (18, 5, N'a. 0.92', 1)
GO
INSERT [dbo].[Choices] ([ChoiceID], [QuestionID], [Description], [IsTrueAnswer]) VALUES (19, 5, N'b. 0.06', 0)
GO
INSERT [dbo].[Choices] ([ChoiceID], [QuestionID], [Description], [IsTrueAnswer]) VALUES (20, 5, N'c. 0.94', 0)
GO
INSERT [dbo].[Choices] ([ChoiceID], [QuestionID], [Description], [IsTrueAnswer]) VALUES (21, 5, N'd. 0.50', 0)
GO
INSERT [dbo].[Choices] ([ChoiceID], [QuestionID], [Description], [IsTrueAnswer]) VALUES (22, 6, N'a. cannot determine', 0)
GO
INSERT [dbo].[Choices] ([ChoiceID], [QuestionID], [Description], [IsTrueAnswer]) VALUES (23, 6, N'b. yes', 0)
GO
INSERT [dbo].[Choices] ([ChoiceID], [QuestionID], [Description], [IsTrueAnswer]) VALUES (24, 6, N'c. no', 1)
GO
INSERT [dbo].[Choices] ([ChoiceID], [QuestionID], [Description], [IsTrueAnswer]) VALUES (25, 7, N'a. 0.3', 0)
GO
INSERT [dbo].[Choices] ([ChoiceID], [QuestionID], [Description], [IsTrueAnswer]) VALUES (26, 7, N'b. 0.7', 0)
GO
INSERT [dbo].[Choices] ([ChoiceID], [QuestionID], [Description], [IsTrueAnswer]) VALUES (27, 7, N'c. 0.6', 1)
GO
INSERT [dbo].[Choices] ([ChoiceID], [QuestionID], [Description], [IsTrueAnswer]) VALUES (28, 7, N'd. 0.4', 0)
GO
INSERT [dbo].[Choices] ([ChoiceID], [QuestionID], [Description], [IsTrueAnswer]) VALUES (29, 8, N'a. 0.3152', 0)
GO
INSERT [dbo].[Choices] ([ChoiceID], [QuestionID], [Description], [IsTrueAnswer]) VALUES (30, 8, N'b. 0.0028', 1)
GO
INSERT [dbo].[Choices] ([ChoiceID], [QuestionID], [Description], [IsTrueAnswer]) VALUES (31, 8, N'c. 0.4114', 0)
GO
INSERT [dbo].[Choices] ([ChoiceID], [QuestionID], [Description], [IsTrueAnswer]) VALUES (32, 8, N'd. 0.0159', 0)
GO
INSERT [dbo].[Choices] ([ChoiceID], [QuestionID], [Description], [IsTrueAnswer]) VALUES (33, 9, N'a. 24', 0)
GO
INSERT [dbo].[Choices] ([ChoiceID], [QuestionID], [Description], [IsTrueAnswer]) VALUES (34, 9, N'b. 38', 1)
GO
INSERT [dbo].[Choices] ([ChoiceID], [QuestionID], [Description], [IsTrueAnswer]) VALUES (35, 9, N'c. 19', 0)
GO
INSERT [dbo].[Choices] ([ChoiceID], [QuestionID], [Description], [IsTrueAnswer]) VALUES (36, 9, N'd. 12', 0)
GO
INSERT [dbo].[Choices] ([ChoiceID], [QuestionID], [Description], [IsTrueAnswer]) VALUES (37, 10, N'a. 3.25', 0)
GO
INSERT [dbo].[Choices] ([ChoiceID], [QuestionID], [Description], [IsTrueAnswer]) VALUES (38, 10, N'b. 1.77', 0)
GO
INSERT [dbo].[Choices] ([ChoiceID], [QuestionID], [Description], [IsTrueAnswer]) VALUES (39, 10, N'c. 1.52', 0)
GO
INSERT [dbo].[Choices] ([ChoiceID], [QuestionID], [Description], [IsTrueAnswer]) VALUES (40, 10, N'd. 3.16', 1)
GO
SET IDENTITY_INSERT [dbo].[Choices] OFF
GO
INSERT [dbo].[CourseAssignment] ([UserId], [CourseId]) VALUES (5, 1)
GO
INSERT [dbo].[CourseAssignment] ([UserId], [CourseId]) VALUES (5, 2)
GO
INSERT [dbo].[CourseAssignment] ([UserId], [CourseId]) VALUES (5, 3)
GO
INSERT [dbo].[CourseAssignment] ([UserId], [CourseId]) VALUES (5, 9)
GO
SET IDENTITY_INSERT [dbo].[Courses] ON 
GO
INSERT [dbo].[Courses] ([CourseID], [CourseBannerImage], [Title], [CourseDescription], [PublishDate], [Lecturer], [SemesterID]) VALUES (1, N'https://anhcocvang.com/static/media/SWP391.5fdddbd15263f212b41a.png', N'SWP391', N'Application development project', CAST(N'2023-06-16' AS Date), N'Bùi Đình Chiến (FSE HN - Giảng viên CF)', 1)
GO
INSERT [dbo].[Courses] ([CourseID], [CourseBannerImage], [Title], [CourseDescription], [PublishDate], [Lecturer], [SemesterID]) VALUES (2, N'https://anhcocvang.com/static/media/PRJ301.9bb0efe8026c7b713544.png', N'PRJ301', N'Java Web Application Development', CAST(N'2023-01-01' AS Date), N'Bùi Ngọc Anh (FSE HN - Giảng viên CF)', 1)
GO
INSERT [dbo].[Courses] ([CourseID], [CourseBannerImage], [Title], [CourseDescription], [PublishDate], [Lecturer], [SemesterID]) VALUES (3, N'https://images.shiksha.com/mediadata/ugcDocuments/images/wordpressImages/2022_08_Understanding-Break-Statement-in-C-24.jpg', N'ACC101', N'Principles of Accounting', CAST(N'2023-11-05' AS Date), N'Phan Trường Lâm (FSE HN - Giảng viên CF)', 3)
GO
INSERT [dbo].[Courses] ([CourseID], [CourseBannerImage], [Title], [CourseDescription], [PublishDate], [Lecturer], [SemesterID]) VALUES (4, N'https://thuvienso.hoasen.edu.vn/bitstream/handle/123456789/7356/71.jpg?sequence=3&isAllowed=y', N'MAS202', N'Applied Statistics for Business', CAST(N'2022-03-07' AS Date), N'Thành Trung Đinh', 1)
GO
INSERT [dbo].[Courses] ([CourseID], [CourseBannerImage], [Title], [CourseDescription], [PublishDate], [Lecturer], [SemesterID]) VALUES (5, N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTUsnXxxnW_XjosAEGoZhotT7c4OHv9GDmChKMyBqqSww&s', N'FIN201', N'Monetary Economics and Global Economy', CAST(N'2022-10-12' AS Date), N'Nguyễn Minh Hải (FSB HN)', 3)
GO
INSERT [dbo].[Courses] ([CourseID], [CourseBannerImage], [Title], [CourseDescription], [PublishDate], [Lecturer], [SemesterID]) VALUES (6, N'https://kent.vn/wp-content/uploads/2019/08/typography1.png', N'TPG203', N'Basic typography & Layout', CAST(N'2022-10-12' AS Date), N'Bùi Ngọc Anh (FSE HN - Giảng viên CF)', 2)
GO
INSERT [dbo].[Courses] ([CourseID], [CourseBannerImage], [Title], [CourseDescription], [PublishDate], [Lecturer], [SemesterID]) VALUES (7, N'https://about.easil.com/wp-content/uploads/67_awesome_visual_design_tools_custom-1.jpg', N'DTG102', N'Visual Design Tools', CAST(N'2022-10-05' AS Date), N'Bùi Ngọc Anh (FSE HN - Giảng viên CF)', 3)
GO
INSERT [dbo].[Courses] ([CourseID], [CourseBannerImage], [Title], [CourseDescription], [PublishDate], [Lecturer], [SemesterID]) VALUES (8, N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQhxWGoQnWWP2ErfXgXv6yze24fS_LQD727tMBypmjR6w&s', N'ENM301', N'BUSINESS ENGLISH - Level: Intermediate', CAST(N'2022-11-11' AS Date), N'Nguyễn Thị Quỳnh Hoa (FSE HN - Giảng viên Tiếng Anh)', 3)
GO
INSERT [dbo].[Courses] ([CourseID], [CourseBannerImage], [Title], [CourseDescription], [PublishDate], [Lecturer], [SemesterID]) VALUES (9, N'https://www.gcreddy.com/wp-content/uploads/2022/10/Introduction-To-Databases.png', N'DBI202', N'Introduction to Database ', CAST(N'2022-10-11' AS Date), N' Bùi Ngọc Anh (FSE HN - Giảng viên CF)', 1)
GO
SET IDENTITY_INSERT [dbo].[Courses] OFF
GO
SET IDENTITY_INSERT [dbo].[Class] ON 
GO
-- Insert sample classes
INSERT INTO [dbo].[Class] ([ClassName], [SemesterID])
VALUES ('SE1840', 1), ('SE1835', 1);

GO
SET IDENTITY_INSERT [dbo].[Exams] OFF
SET IDENTITY_INSERT [dbo].[Exams] ON 
GO
INSERT [dbo].[Exams] ([ExamID], [ExamName], [CourseID], [Duration]) VALUES (1, N'Module 1 Exam', 1, CAST(N'00:30:00' AS Time))
GO
SET IDENTITY_INSERT [dbo].[Exams] OFF
GO
SET IDENTITY_INSERT [dbo].[Questions] ON 
GO
INSERT [dbo].[Questions] ([QuestionID], [QuestionDetail], [ExamID]) VALUES (1, N'Which of the following is not an element of descriptive statistical problems?', 1)
GO
INSERT [dbo].[Questions] ([QuestionID], [QuestionDetail], [ExamID]) VALUES (2, N'A bag of colored candies contains 20 red, 25 yellow, 15 blue and 20 orange candies. An experiment consists of randomly choosing one candy from the bag and recording its color. What is the sample space for this experiment?', 1)
GO
INSERT [dbo].[Questions] ([QuestionID], [QuestionDetail], [ExamID]) VALUES (3, N'Sixty-five percent of men consider themselves knowledgeable football fans. If 15 men are randomly selected, find the probability that exactly five of them will consider themselves knowledgeable fans.', 1)
GO
INSERT [dbo].[Questions] ([QuestionID], [QuestionDetail], [ExamID]) VALUES (4, N'The conditional probability of event G, given the knowledge that event H has occurred, would be written as _____.', 1)
GO
INSERT [dbo].[Questions] ([QuestionID], [QuestionDetail], [ExamID]) VALUES (5, N'A company has 2 machines that produce widgets. An older machine produces 23% defective widgets, while the new machine produces only 8% defective widgets. In addition, the new machine produces 3 times as many widgets as the older machine does. Given that a widget was produced by the new machine, what is the probability it is not defective?', 1)
GO
INSERT [dbo].[Questions] ([QuestionID], [QuestionDetail], [ExamID]) VALUES (6, N'If P(A) = 0.45, P(B) = 0.25, and P(B|A) = 0.45, are A and B independent?', 1)
GO
INSERT [dbo].[Questions] ([QuestionID], [QuestionDetail], [ExamID]) VALUES (7, N'It was found that 60% of the workers were white, 30% were black and 10% are other races. Given that a worker was white, the probability that the worker had claimed bias was 30%. Given that a worker was black, the probability that the worker had claimed bias was 40%. Given that a worker was other race, the probability that the worker had claimed bias was 0%. If a randomly selected worker had claimed bias, what is the probability that the worker is white?', 1)
GO
INSERT [dbo].[Questions] ([QuestionID], [QuestionDetail], [ExamID]) VALUES (8, N'Samples of 10 parts from a metal punching process are selected every hour. Let X denote the number of parts in the sample of 10 that require rework. If the percentage of parts that require rework at 3%, what is the probability that X exceeds 2?', 1)
GO
INSERT [dbo].[Questions] ([QuestionID], [QuestionDetail], [ExamID]) VALUES (9, N'The range of the random variable X is {1, 2, 3, 6, u}, where u is unknown. If each value is equally likely and the mean of X is 10, determine the value of u.', 1)
GO
INSERT [dbo].[Questions] ([QuestionID], [QuestionDetail], [ExamID]) VALUES (10, N'The probability that a radish seed will germinate is 0.26. A gardener plants seeds in batches of 52. Find the standard deviation for the random variable X, the number of seeds germinating in each batch.', 1)
GO
SET IDENTITY_INSERT [dbo].[Questions] OFF
GO
SET IDENTITY_INSERT [dbo].[Semesters] ON 
GO
INSERT [dbo].[Semesters] ([SemesterID], [SemesterDescription], [StartDate], [EndDate]) VALUES (1, N'SUMMER 2024', NULL, NULL)
GO
INSERT [dbo].[Semesters] ([SemesterID], [SemesterDescription], [StartDate], [EndDate]) VALUES (2, N'SPRING 2024', NULL, NULL)
GO
INSERT [dbo].[Semesters] ([SemesterID], [SemesterDescription], [StartDate], [EndDate]) VALUES (3, N'FALL 2023', NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[Semesters] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 
GO
INSERT [dbo].[Users] ([UserID], [UserName], [Email], [Role], [DOB], [Gender], [PhoneNumber], [RestrictedUntil], [RestrictedReason]) VALUES (1, N'admin', N'admin@gmail.com', 4, NULL, NULL, NULL, CAST(N'2000-01-01T00:00:00.000' AS DateTime), NULL)
GO
INSERT [dbo].[Users] ([UserID], [UserName], [Email], [Role], [DOB], [Gender], [PhoneNumber], [RestrictedUntil], [RestrictedReason]) VALUES (2, N'manager', N'manager@gmail.com', 3, NULL, NULL, NULL, CAST(N'2000-01-01T00:00:00.000' AS DateTime), NULL)
GO
INSERT [dbo].[Users] ([UserID], [UserName], [Email], [Role], [DOB], [Gender], [PhoneNumber], [RestrictedUntil], [RestrictedReason]) VALUES (3, N'teacher', N'teacher@gmail.com', 2, NULL, NULL, NULL, CAST(N'2000-01-01T00:00:00.000' AS DateTime), NULL)
GO
INSERT [dbo].[Users] ([UserID], [UserName], [Email], [Role], [DOB], [Gender], [PhoneNumber], [RestrictedUntil], [RestrictedReason]) VALUES (4, N'user', N'user@gmail.com', 1, NULL, NULL, NULL, CAST(N'2000-01-01T00:00:00.000' AS DateTime), NULL)
GO
INSERT [dbo].[Users] ([UserID], [UserName], [Email], [Role], [DOB], [Gender], [PhoneNumber], [RestrictedUntil], [RestrictedReason]) VALUES (5, N'lamtung', N'tungnlhe180026@fpt.edu.vn', 2, NULL, NULL, NULL, CAST(N'2000-01-01T00:00:00.000' AS DateTime), NULL)
GO
-- Link the course to a class
DECLARE @CourseID INT;
SET @CourseID = SCOPE_IDENTITY(); -- Get the newly inserted CourseID

-- Assuming ClassID is known (e.g., 1 for Class A)
UPDATE [dbo].[Class]
SET [SemesterID] = 1 -- Set the appropriate SemesterID
WHERE [ClassID] = 1;

-- Associate the course with the class
INSERT INTO [dbo].[ClassCourses] ([ClassID], [CourseID])
VALUES (1, 1); -- Assuming ClassID is 1
INSERT INTO [dbo].[ClassCourses] ([ClassID], [CourseID])
VALUES (1, 2);
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
ALTER TABLE [dbo].[Choices] ADD  DEFAULT ((0)) FOR [IsTrueAnswer]
GO
ALTER TABLE [dbo].[Courses] ADD  DEFAULT (NULL) FOR [PublishDate]
GO
ALTER TABLE [dbo].[ExamPapers] ADD  DEFAULT (getdate()) FOR [TimeStart]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT ('2000-01-01 00:00:00') FOR [RestrictedUntil]
GO
ALTER TABLE [dbo].[Choices]  WITH CHECK ADD FOREIGN KEY([QuestionID])
REFERENCES [dbo].[Questions] ([QuestionID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CourseAssignment]  WITH CHECK ADD FOREIGN KEY([CourseId])
REFERENCES [dbo].[Courses] ([CourseID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CourseAssignment]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Courses]  WITH CHECK ADD FOREIGN KEY([SemesterID])
REFERENCES [dbo].[Semesters] ([SemesterID])
GO
ALTER TABLE [dbo].[ExamPapers]  WITH CHECK ADD FOREIGN KEY([ExamID])
REFERENCES [dbo].[Exams] ([ExamID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ExamPapers]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Exams]  WITH CHECK ADD FOREIGN KEY([CourseID])
REFERENCES [dbo].[Courses] ([CourseID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Questions]  WITH CHECK ADD FOREIGN KEY([ExamID])
REFERENCES [dbo].[Exams] ([ExamID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserAnswers]  WITH CHECK ADD FOREIGN KEY([ChoiceID])
REFERENCES [dbo].[Choices] ([ChoiceID])
GO
ALTER TABLE [dbo].[UserAnswers]  WITH CHECK ADD FOREIGN KEY([PaperID])
REFERENCES [dbo].[ExamPapers] ([PaperID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ExamPapers]  WITH CHECK ADD CHECK  (([State]=(2) OR [State]=(1)))
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD CHECK  (([Role]=(4) OR [Role]=(3) OR [Role]=(2) OR [Role]=(1)))
GO
USE [master]
GO
ALTER DATABASE [SWP391_SU24] SET  READ_WRITE 
GO
