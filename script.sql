USE [master]
GO
/****** Object:  Database [QuizOnlineDB]    Script Date: 2/3/2021 11:14:11 PM ******/
CREATE DATABASE [QuizOnlineDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'QuizOnlineDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\QuizOnlineDB.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'QuizOnlineDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\QuizOnlineDB_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [QuizOnlineDB] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QuizOnlineDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QuizOnlineDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QuizOnlineDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QuizOnlineDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QuizOnlineDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QuizOnlineDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [QuizOnlineDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [QuizOnlineDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QuizOnlineDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QuizOnlineDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QuizOnlineDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QuizOnlineDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QuizOnlineDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QuizOnlineDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QuizOnlineDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QuizOnlineDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [QuizOnlineDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QuizOnlineDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QuizOnlineDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QuizOnlineDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QuizOnlineDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QuizOnlineDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QuizOnlineDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QuizOnlineDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [QuizOnlineDB] SET  MULTI_USER 
GO
ALTER DATABASE [QuizOnlineDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QuizOnlineDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QuizOnlineDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QuizOnlineDB] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [QuizOnlineDB] SET DELAYED_DURABILITY = DISABLED 
GO
USE [QuizOnlineDB]
GO
/****** Object:  Table [dbo].[Answer]    Script Date: 2/3/2021 11:14:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Answer](
	[answer_id] [varchar](30) NOT NULL,
	[answer_content] [nvarchar](100) NOT NULL,
	[is_correct] [bit] NOT NULL,
	[question_id] [varchar](30) NOT NULL,
 CONSTRAINT [PK_Answer] PRIMARY KEY CLUSTERED 
(
	[answer_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Question]    Script Date: 2/3/2021 11:14:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Question](
	[question_id] [varchar](30) NOT NULL,
	[question_content] [nvarchar](200) NOT NULL,
	[create_date] [datetime] NOT NULL,
	[subject_id] [varchar](30) NOT NULL,
	[status] [bit] NOT NULL,
 CONSTRAINT [PK_Question] PRIMARY KEY CLUSTERED 
(
	[question_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Quiz]    Script Date: 2/3/2021 11:14:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Quiz](
	[quiz_id] [varchar](50) NULL,
	[subject_id] [varchar](30) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[QuizDetails]    Script Date: 2/3/2021 11:14:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[QuizDetails](
	[question_id] [varchar](30) NOT NULL,
	[question_content] [nvarchar](200) NOT NULL,
	[is_right] [bit] NULL,
	[choosed_answer] [nvarchar](100) NULL,
	[correct_answer] [nvarchar](100) NOT NULL,
	[quiz_id] [varchar](50) NOT NULL,
	[ansA] [nvarchar](100) NOT NULL,
	[ansB] [nvarchar](100) NOT NULL,
	[ansC] [nvarchar](100) NOT NULL,
	[ansD] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_QuizDetails] PRIMARY KEY CLUSTERED 
(
	[question_id] ASC,
	[quiz_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[QuizUser]    Script Date: 2/3/2021 11:14:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[QuizUser](
	[email] [varchar](100) NOT NULL,
	[quiz_id] [varchar](50) NOT NULL,
	[date] [datetime] NOT NULL,
	[mark] [int] NOT NULL,
	[subject_id] [varchar](30) NOT NULL,
	[isSubmit] [bit] NULL,
 CONSTRAINT [PK_QuizUser] PRIMARY KEY CLUSTERED 
(
	[email] ASC,
	[quiz_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SubjectDB]    Script Date: 2/3/2021 11:14:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SubjectDB](
	[subject_id] [varchar](30) NOT NULL,
	[subject_name] [nvarchar](50) NOT NULL,
	[description] [nvarchar](500) NULL,
 CONSTRAINT [PK_SubjectDB] PRIMARY KEY CLUSTERED 
(
	[subject_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UserDB]    Script Date: 2/3/2021 11:14:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UserDB](
	[email] [varchar](100) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[password] [varchar](100) NOT NULL,
	[role] [bit] NOT NULL,
	[status] [bit] NOT NULL,
 CONSTRAINT [PK_Account] PRIMARY KEY CLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[Answer] ([answer_id], [answer_content], [is_correct], [question_id]) VALUES (N'a123', N'Compile error', 1, N'q123')
INSERT [dbo].[Answer] ([answer_id], [answer_content], [is_correct], [question_id]) VALUES (N'a124', N'Hi ', 0, N'q123')
INSERT [dbo].[Answer] ([answer_id], [answer_content], [is_correct], [question_id]) VALUES (N'a125', N'HelloHi', 0, N'q123')
INSERT [dbo].[Answer] ([answer_id], [answer_content], [is_correct], [question_id]) VALUES (N'a126', N'Compiler warning', 0, N'q123')
INSERT [dbo].[Answer] ([answer_id], [answer_content], [is_correct], [question_id]) VALUES (N'a127', N'5 5 5', 1, N'q124')
INSERT [dbo].[Answer] ([answer_id], [answer_content], [is_correct], [question_id]) VALUES (N'a128', N'5 5 garbage value', 0, N'q124')
INSERT [dbo].[Answer] ([answer_id], [answer_content], [is_correct], [question_id]) VALUES (N'a129', N'5 5 0', 0, N'q124')
INSERT [dbo].[Answer] ([answer_id], [answer_content], [is_correct], [question_id]) VALUES (N'a130', N'Compile error', 0, N'q124')
INSERT [dbo].[Answer] ([answer_id], [answer_content], [is_correct], [question_id]) VALUES (N'a131', N'1 2', 0, N'q125')
INSERT [dbo].[Answer] ([answer_id], [answer_content], [is_correct], [question_id]) VALUES (N'a132', N'1 2 3', 0, N'q125')
INSERT [dbo].[Answer] ([answer_id], [answer_content], [is_correct], [question_id]) VALUES (N'a133', N'1 2 4 5', 0, N'q125')
INSERT [dbo].[Answer] ([answer_id], [answer_content], [is_correct], [question_id]) VALUES (N'a134', N'Compile error', 1, N'q125')
INSERT [dbo].[Answer] ([answer_id], [answer_content], [is_correct], [question_id]) VALUES (N'a135', N'3 2 1', 0, N'q126')
INSERT [dbo].[Answer] ([answer_id], [answer_content], [is_correct], [question_id]) VALUES (N'a136', N'3 2 1', 0, N'q126')
INSERT [dbo].[Answer] ([answer_id], [answer_content], [is_correct], [question_id]) VALUES (N'a137', N'3 3 3 aaaa', 1, N'q126')
INSERT [dbo].[Answer] ([answer_id], [answer_content], [is_correct], [question_id]) VALUES (N'a138', N'Compile error', 0, N'q126')
INSERT [dbo].[Answer] ([answer_id], [answer_content], [is_correct], [question_id]) VALUES (N'a139', N'#', 0, N'q127')
INSERT [dbo].[Answer] ([answer_id], [answer_content], [is_correct], [question_id]) VALUES (N'a140', N'##', 0, N'q127')
INSERT [dbo].[Answer] ([answer_id], [answer_content], [is_correct], [question_id]) VALUES (N'a141', N'?', 1, N'q127')
INSERT [dbo].[Answer] ([answer_id], [answer_content], [is_correct], [question_id]) VALUES (N'a142', N'??', 0, N'q127')
INSERT [dbo].[Answer] ([answer_id], [answer_content], [is_correct], [question_id]) VALUES (N'ans1612107122570-1', N'123', 0, N'q1612107122570')
INSERT [dbo].[Answer] ([answer_id], [answer_content], [is_correct], [question_id]) VALUES (N'ans1612107122570-2', N'456', 0, N'q1612107122570')
INSERT [dbo].[Answer] ([answer_id], [answer_content], [is_correct], [question_id]) VALUES (N'ans1612107122570-3', N'789', 1, N'q1612107122570')
INSERT [dbo].[Answer] ([answer_id], [answer_content], [is_correct], [question_id]) VALUES (N'ans1612107122570-4', N'000', 0, N'q1612107122570')
INSERT [dbo].[Answer] ([answer_id], [answer_content], [is_correct], [question_id]) VALUES (N'ans1612107152520-1', N'111', 1, N'q1612107152520')
INSERT [dbo].[Answer] ([answer_id], [answer_content], [is_correct], [question_id]) VALUES (N'ans1612107152520-2', N'222', 0, N'q1612107152520')
INSERT [dbo].[Answer] ([answer_id], [answer_content], [is_correct], [question_id]) VALUES (N'ans1612107152520-3', N'333', 0, N'q1612107152520')
INSERT [dbo].[Answer] ([answer_id], [answer_content], [is_correct], [question_id]) VALUES (N'ans1612107152520-4', N'444', 0, N'q1612107152520')
INSERT [dbo].[Answer] ([answer_id], [answer_content], [is_correct], [question_id]) VALUES (N'ans1612368738086-1', N'2', 0, N'q1612368738086')
INSERT [dbo].[Answer] ([answer_id], [answer_content], [is_correct], [question_id]) VALUES (N'ans1612368738086-2', N'3', 1, N'q1612368738086')
INSERT [dbo].[Answer] ([answer_id], [answer_content], [is_correct], [question_id]) VALUES (N'ans1612368738086-3', N'4', 0, N'q1612368738086')
INSERT [dbo].[Answer] ([answer_id], [answer_content], [is_correct], [question_id]) VALUES (N'ans1612368738086-4', N'5', 0, N'q1612368738086')
INSERT [dbo].[Question] ([question_id], [question_content], [create_date], [subject_id], [status]) VALUES (N'q123', N'a#include<stdio.h>
main() 
{
   int x = 5;
   
   if(x=5)
   {	
       if(x=5) break;
       printf("Hello");
   } 
   printf("Hi");
}', CAST(N'2021-01-27 00:00:00.000' AS DateTime), N'sj123', 0)
INSERT [dbo].[Question] ([question_id], [question_content], [create_date], [subject_id], [status]) VALUES (N'q124', N'#include<stdio.h>

main()
{ 
   struct { int x;} var = {5}, *p = &var;
   
   printf("%d %d %d",var.x,p->x,(*p).x); 
}', CAST(N'2021-01-27 00:00:00.000' AS DateTime), N'sj123', 1)
INSERT [dbo].[Question] ([question_id], [question_content], [create_date], [subject_id], [status]) VALUES (N'q125', N'#include<stdio.h>

main()
{
   int i = 1;
   
   Charminar:
   printf("%d ",i++);
   if(i==3) break;
   if(i<=5) goto Charminar;
}', CAST(N'2021-01-27 00:00:00.000' AS DateTime), N'sj123', 0)
INSERT [dbo].[Question] ([question_id], [question_content], [create_date], [subject_id], [status]) VALUES (N'q126', N'c#include<stdio.h>
void f() 
{
   static int i = 3;
   
   printf("%d ", i);
   if(--i) f();
}
main() 
{
   f();
}', CAST(N'2021-01-27 00:00:00.000' AS DateTime), N'sj123', 0)
INSERT [dbo].[Question] ([question_id], [question_content], [create_date], [subject_id], [status]) VALUES (N'q127', N'bA trigraph character begins with', CAST(N'2021-01-28 00:00:00.000' AS DateTime), N'sj124', 0)
INSERT [dbo].[Question] ([question_id], [question_content], [create_date], [subject_id], [status]) VALUES (N'q1612368738086', N'1+1 = ?', CAST(N'2021-02-03 23:12:33.450' AS DateTime), N'sj123', 1)
INSERT [dbo].[QuizDetails] ([question_id], [question_content], [is_right], [choosed_answer], [correct_answer], [quiz_id], [ansA], [ansB], [ansC], [ansD]) VALUES (N'q123', N'a#include<stdio.h>
main() 
{
   int x = 5;
   
   if(x=5)
   {	
       if(x=5) break;
       printf("Hello");
   } 
   printf("Hi");
}', NULL, NULL, N'Compile error', N'1612366059484', N'Compile error', N'Hi ', N'HelloHi', N'Compiler warning')
INSERT [dbo].[QuizDetails] ([question_id], [question_content], [is_right], [choosed_answer], [correct_answer], [quiz_id], [ansA], [ansB], [ansC], [ansD]) VALUES (N'q124', N'#include<stdio.h>

main()
{ 
   struct { int x;} var = {5}, *p = &var;
   
   printf("%d %d %d",var.x,p->x,(*p).x); 
}', NULL, NULL, N'5 5 5', N'1612366059484', N'5 5 5', N'5 5 garbage value', N'5 5 0', N'Compile error')
INSERT [dbo].[QuizDetails] ([question_id], [question_content], [is_right], [choosed_answer], [correct_answer], [quiz_id], [ansA], [ansB], [ansC], [ansD]) VALUES (N'q125', N'#include<stdio.h>

main()
{
   int i = 1;
   
   Charminar:
   printf("%d ",i++);
   if(i==3) break;
   if(i<=5) goto Charminar;
}', NULL, NULL, N'Compile error', N'1612366059484', N'1 2', N'1 2 3', N'1 2 4 5', N'Compile error')
INSERT [dbo].[QuizDetails] ([question_id], [question_content], [is_right], [choosed_answer], [correct_answer], [quiz_id], [ansA], [ansB], [ansC], [ansD]) VALUES (N'q126', N'c#include<stdio.h>
void f() 
{
   static int i = 3;
   
   printf("%d ", i);
   if(--i) f();
}
main() 
{
   f();
}', NULL, NULL, N'3 3 3 aaaa', N'1612366059484', N'3 2 1', N'3 2 1', N'3 3 3 aaaa', N'Compile error')
INSERT [dbo].[QuizUser] ([email], [quiz_id], [date], [mark], [subject_id], [isSubmit]) VALUES (N'loi@giocong.com', N'1612347169057', CAST(N'2021-02-03 17:12:49.057' AS DateTime), 0, N'sj123', NULL)
INSERT [dbo].[QuizUser] ([email], [quiz_id], [date], [mark], [subject_id], [isSubmit]) VALUES (N'loi@giocong.com', N'1612347363324', CAST(N'2021-02-03 17:16:03.323' AS DateTime), 0, N'sj123', NULL)
INSERT [dbo].[QuizUser] ([email], [quiz_id], [date], [mark], [subject_id], [isSubmit]) VALUES (N'loi@giocong.com', N'1612356497991', CAST(N'2021-02-03 19:48:17.990' AS DateTime), 0, N'sj123', NULL)
INSERT [dbo].[QuizUser] ([email], [quiz_id], [date], [mark], [subject_id], [isSubmit]) VALUES (N'loi@giocong.com', N'1612356513698', CAST(N'2021-02-03 19:48:33.697' AS DateTime), 0, N'sj123', NULL)
INSERT [dbo].[QuizUser] ([email], [quiz_id], [date], [mark], [subject_id], [isSubmit]) VALUES (N'loi@giocong.com', N'1612356521799', CAST(N'2021-02-03 19:48:41.797' AS DateTime), 0, N'sj123', NULL)
INSERT [dbo].[QuizUser] ([email], [quiz_id], [date], [mark], [subject_id], [isSubmit]) VALUES (N'loi@giocong.com', N'1612356545565', CAST(N'2021-02-03 19:49:05.563' AS DateTime), 0, N'sj123', NULL)
INSERT [dbo].[QuizUser] ([email], [quiz_id], [date], [mark], [subject_id], [isSubmit]) VALUES (N'loi@giocong.com', N'1612356595301', CAST(N'2021-02-03 19:49:55.300' AS DateTime), 0, N'sj123', NULL)
INSERT [dbo].[QuizUser] ([email], [quiz_id], [date], [mark], [subject_id], [isSubmit]) VALUES (N'loi@giocong.com', N'1612356612110', CAST(N'2021-02-03 19:50:12.110' AS DateTime), 0, N'sj123', NULL)
INSERT [dbo].[QuizUser] ([email], [quiz_id], [date], [mark], [subject_id], [isSubmit]) VALUES (N'loi@giocong.com', N'1612356637303', CAST(N'2021-02-03 19:50:37.303' AS DateTime), 0, N'sj123', NULL)
INSERT [dbo].[QuizUser] ([email], [quiz_id], [date], [mark], [subject_id], [isSubmit]) VALUES (N'loi@giocong.com', N'1612356654181', CAST(N'2021-02-03 19:50:54.180' AS DateTime), 0, N'sj123', NULL)
INSERT [dbo].[QuizUser] ([email], [quiz_id], [date], [mark], [subject_id], [isSubmit]) VALUES (N'loi@giocong.com', N'1612356664693', CAST(N'2021-02-03 19:51:04.690' AS DateTime), 0, N'sj123', NULL)
INSERT [dbo].[QuizUser] ([email], [quiz_id], [date], [mark], [subject_id], [isSubmit]) VALUES (N'loi@giocong.com', N'1612356674653', CAST(N'2021-02-03 19:51:14.650' AS DateTime), 0, N'sj123', NULL)
INSERT [dbo].[QuizUser] ([email], [quiz_id], [date], [mark], [subject_id], [isSubmit]) VALUES (N'loi@giocong.com', N'1612356717113', CAST(N'2021-02-03 19:51:57.110' AS DateTime), 0, N'sj123', NULL)
INSERT [dbo].[QuizUser] ([email], [quiz_id], [date], [mark], [subject_id], [isSubmit]) VALUES (N'loi@giocong.com', N'1612356742096', CAST(N'2021-02-03 19:52:22.093' AS DateTime), 0, N'sj123', NULL)
INSERT [dbo].[QuizUser] ([email], [quiz_id], [date], [mark], [subject_id], [isSubmit]) VALUES (N'loi@giocong.com', N'1612357035951', CAST(N'2021-02-03 19:57:15.950' AS DateTime), 0, N'sj123', NULL)
INSERT [dbo].[QuizUser] ([email], [quiz_id], [date], [mark], [subject_id], [isSubmit]) VALUES (N'loi@giocong.com', N'1612357227671', CAST(N'2021-02-03 20:00:27.670' AS DateTime), 0, N'sj123', NULL)
INSERT [dbo].[QuizUser] ([email], [quiz_id], [date], [mark], [subject_id], [isSubmit]) VALUES (N'loi@giocong.com', N'1612357246802', CAST(N'2021-02-03 20:00:46.800' AS DateTime), 0, N'sj123', NULL)
INSERT [dbo].[QuizUser] ([email], [quiz_id], [date], [mark], [subject_id], [isSubmit]) VALUES (N'loi@giocong.com', N'1612357274706', CAST(N'2021-02-03 20:01:14.703' AS DateTime), 0, N'sj123', NULL)
INSERT [dbo].[QuizUser] ([email], [quiz_id], [date], [mark], [subject_id], [isSubmit]) VALUES (N'loi@giocong.com', N'1612357290384', CAST(N'2021-02-03 20:01:30.383' AS DateTime), 0, N'sj123', NULL)
INSERT [dbo].[QuizUser] ([email], [quiz_id], [date], [mark], [subject_id], [isSubmit]) VALUES (N'loi@giocong.com', N'1612357310186', CAST(N'2021-02-03 20:01:50.183' AS DateTime), 0, N'sj123', NULL)
INSERT [dbo].[QuizUser] ([email], [quiz_id], [date], [mark], [subject_id], [isSubmit]) VALUES (N'loi@giocong.com', N'1612357326892', CAST(N'2021-02-03 20:02:06.890' AS DateTime), 0, N'sj123', NULL)
INSERT [dbo].[QuizUser] ([email], [quiz_id], [date], [mark], [subject_id], [isSubmit]) VALUES (N'loi@giocong.com', N'1612357351234', CAST(N'2021-02-03 20:02:31.233' AS DateTime), 0, N'sj123', NULL)
INSERT [dbo].[QuizUser] ([email], [quiz_id], [date], [mark], [subject_id], [isSubmit]) VALUES (N'loi@giocong.com', N'1612357416177', CAST(N'2021-02-03 20:03:36.177' AS DateTime), 0, N'sj123', NULL)
INSERT [dbo].[QuizUser] ([email], [quiz_id], [date], [mark], [subject_id], [isSubmit]) VALUES (N'loi@giocong.com', N'1612357439756', CAST(N'2021-02-03 20:03:59.753' AS DateTime), 0, N'sj123', NULL)
INSERT [dbo].[QuizUser] ([email], [quiz_id], [date], [mark], [subject_id], [isSubmit]) VALUES (N'loi@giocong.com', N'1612357514781', CAST(N'2021-02-03 20:05:14.780' AS DateTime), 0, N'sj123', NULL)
INSERT [dbo].[QuizUser] ([email], [quiz_id], [date], [mark], [subject_id], [isSubmit]) VALUES (N'loi@giocong.com', N'1612357537002', CAST(N'2021-02-03 20:05:37.000' AS DateTime), 0, N'sj123', NULL)
INSERT [dbo].[QuizUser] ([email], [quiz_id], [date], [mark], [subject_id], [isSubmit]) VALUES (N'loi@giocong.com', N'1612357558028', CAST(N'2021-02-03 20:05:58.030' AS DateTime), 0, N'sj123', NULL)
INSERT [dbo].[QuizUser] ([email], [quiz_id], [date], [mark], [subject_id], [isSubmit]) VALUES (N'loi@giocong.com', N'1612357567900', CAST(N'2021-02-03 20:06:07.900' AS DateTime), 0, N'sj123', NULL)
INSERT [dbo].[QuizUser] ([email], [quiz_id], [date], [mark], [subject_id], [isSubmit]) VALUES (N'loi@giocong.com', N'1612357589591', CAST(N'2021-02-03 20:06:29.590' AS DateTime), 0, N'sj123', NULL)
INSERT [dbo].[QuizUser] ([email], [quiz_id], [date], [mark], [subject_id], [isSubmit]) VALUES (N'loi@giocong.com', N'1612357608482', CAST(N'2021-02-03 20:06:48.480' AS DateTime), 0, N'sj123', NULL)
INSERT [dbo].[QuizUser] ([email], [quiz_id], [date], [mark], [subject_id], [isSubmit]) VALUES (N'loi@giocong.com', N'1612357646225', CAST(N'2021-02-03 20:07:26.223' AS DateTime), 0, N'sj123', NULL)
INSERT [dbo].[QuizUser] ([email], [quiz_id], [date], [mark], [subject_id], [isSubmit]) VALUES (N'loi@giocong.com', N'1612357666344', CAST(N'2021-02-03 20:07:46.343' AS DateTime), 0, N'sj123', NULL)
INSERT [dbo].[QuizUser] ([email], [quiz_id], [date], [mark], [subject_id], [isSubmit]) VALUES (N'loi@giocong.com', N'1612357701783', CAST(N'2021-02-03 20:08:21.780' AS DateTime), 0, N'sj123', NULL)
INSERT [dbo].[QuizUser] ([email], [quiz_id], [date], [mark], [subject_id], [isSubmit]) VALUES (N'loi@giocong.com', N'1612357721166', CAST(N'2021-02-03 20:08:41.163' AS DateTime), 0, N'sj123', NULL)
INSERT [dbo].[QuizUser] ([email], [quiz_id], [date], [mark], [subject_id], [isSubmit]) VALUES (N'loi@giocong.com', N'1612357831379', CAST(N'2021-02-03 20:10:31.380' AS DateTime), 0, N'sj123', NULL)
INSERT [dbo].[QuizUser] ([email], [quiz_id], [date], [mark], [subject_id], [isSubmit]) VALUES (N'loi@giocong.com', N'1612357846918', CAST(N'2021-02-03 20:10:46.917' AS DateTime), 0, N'sj123', NULL)
INSERT [dbo].[QuizUser] ([email], [quiz_id], [date], [mark], [subject_id], [isSubmit]) VALUES (N'loi@giocong.com', N'1612357895145', CAST(N'2021-02-03 20:11:35.143' AS DateTime), 0, N'sj123', NULL)
INSERT [dbo].[QuizUser] ([email], [quiz_id], [date], [mark], [subject_id], [isSubmit]) VALUES (N'loi@giocong.com', N'1612357913348', CAST(N'2021-02-03 20:11:53.347' AS DateTime), 0, N'sj123', NULL)
INSERT [dbo].[QuizUser] ([email], [quiz_id], [date], [mark], [subject_id], [isSubmit]) VALUES (N'loi@giocong.com', N'1612357922835', CAST(N'2021-02-03 20:12:02.833' AS DateTime), 0, N'sj123', NULL)
INSERT [dbo].[QuizUser] ([email], [quiz_id], [date], [mark], [subject_id], [isSubmit]) VALUES (N'loi@giocong.com', N'1612357930236', CAST(N'2021-02-03 20:12:10.237' AS DateTime), 0, N'sj123', NULL)
INSERT [dbo].[QuizUser] ([email], [quiz_id], [date], [mark], [subject_id], [isSubmit]) VALUES (N'loi@giocong.com', N'1612358766785', CAST(N'2021-02-03 20:26:06.783' AS DateTime), 0, N'sj123', NULL)
INSERT [dbo].[QuizUser] ([email], [quiz_id], [date], [mark], [subject_id], [isSubmit]) VALUES (N'loi@giocong.com', N'1612358874358', CAST(N'2021-02-03 20:27:54.357' AS DateTime), 0, N'sj123', NULL)
INSERT [dbo].[QuizUser] ([email], [quiz_id], [date], [mark], [subject_id], [isSubmit]) VALUES (N'loi@giocong.com', N'1612358910136', CAST(N'2021-02-03 20:28:30.137' AS DateTime), 0, N'sj123', NULL)
INSERT [dbo].[QuizUser] ([email], [quiz_id], [date], [mark], [subject_id], [isSubmit]) VALUES (N'loi@giocong.com', N'1612358975836', CAST(N'2021-02-03 20:29:35.833' AS DateTime), 0, N'sj123', NULL)
INSERT [dbo].[QuizUser] ([email], [quiz_id], [date], [mark], [subject_id], [isSubmit]) VALUES (N'loi@giocong.com', N'1612359001282', CAST(N'2021-02-03 20:30:01.280' AS DateTime), 0, N'sj123', NULL)
INSERT [dbo].[QuizUser] ([email], [quiz_id], [date], [mark], [subject_id], [isSubmit]) VALUES (N'loi@giocong.com', N'1612359053548', CAST(N'2021-02-03 20:30:53.547' AS DateTime), 0, N'sj123', NULL)
INSERT [dbo].[QuizUser] ([email], [quiz_id], [date], [mark], [subject_id], [isSubmit]) VALUES (N'loi@giocong.com', N'1612359185108', CAST(N'2021-02-03 20:33:05.107' AS DateTime), 0, N'sj123', NULL)
INSERT [dbo].[QuizUser] ([email], [quiz_id], [date], [mark], [subject_id], [isSubmit]) VALUES (N'loi@giocong.com', N'1612359225928', CAST(N'2021-02-03 20:33:45.927' AS DateTime), 0, N'sj123', NULL)
INSERT [dbo].[QuizUser] ([email], [quiz_id], [date], [mark], [subject_id], [isSubmit]) VALUES (N'loi@giocong.com', N'1612359347264', CAST(N'2021-02-03 20:35:47.263' AS DateTime), 0, N'sj123', NULL)
INSERT [dbo].[QuizUser] ([email], [quiz_id], [date], [mark], [subject_id], [isSubmit]) VALUES (N'loi@giocong.com', N'1612359441671', CAST(N'2021-02-03 20:37:21.670' AS DateTime), 0, N'sj123', NULL)
INSERT [dbo].[QuizUser] ([email], [quiz_id], [date], [mark], [subject_id], [isSubmit]) VALUES (N'loi@giocong.com', N'1612359531630', CAST(N'2021-02-03 20:38:51.630' AS DateTime), 0, N'sj123', NULL)
INSERT [dbo].[QuizUser] ([email], [quiz_id], [date], [mark], [subject_id], [isSubmit]) VALUES (N'loi@giocong.com', N'1612359580712', CAST(N'2021-02-03 20:39:40.710' AS DateTime), 0, N'sj123', NULL)
INSERT [dbo].[QuizUser] ([email], [quiz_id], [date], [mark], [subject_id], [isSubmit]) VALUES (N'loi@giocong.com', N'1612359700986', CAST(N'2021-02-03 20:41:40.983' AS DateTime), 0, N'sj123', NULL)
INSERT [dbo].[QuizUser] ([email], [quiz_id], [date], [mark], [subject_id], [isSubmit]) VALUES (N'loi@giocong.com', N'1612359830824', CAST(N'2021-02-03 20:43:50.823' AS DateTime), 0, N'sj123', NULL)
INSERT [dbo].[QuizUser] ([email], [quiz_id], [date], [mark], [subject_id], [isSubmit]) VALUES (N'loi@giocong.com', N'1612359884014', CAST(N'2021-02-03 20:44:44.013' AS DateTime), 0, N'sj123', NULL)
INSERT [dbo].[QuizUser] ([email], [quiz_id], [date], [mark], [subject_id], [isSubmit]) VALUES (N'loi@giocong.com', N'1612359919599', CAST(N'2021-02-03 20:45:19.597' AS DateTime), 0, N'sj123', NULL)
INSERT [dbo].[QuizUser] ([email], [quiz_id], [date], [mark], [subject_id], [isSubmit]) VALUES (N'loi@giocong.com', N'1612359935815', CAST(N'2021-02-03 20:45:35.813' AS DateTime), 0, N'sj123', NULL)
INSERT [dbo].[QuizUser] ([email], [quiz_id], [date], [mark], [subject_id], [isSubmit]) VALUES (N'loi@giocong.com', N'1612359948599', CAST(N'2021-02-03 20:45:48.597' AS DateTime), 0, N'sj123', NULL)
INSERT [dbo].[QuizUser] ([email], [quiz_id], [date], [mark], [subject_id], [isSubmit]) VALUES (N'loi@giocong.com', N'1612359997494', CAST(N'2021-02-03 20:46:37.493' AS DateTime), 0, N'sj123', NULL)
INSERT [dbo].[QuizUser] ([email], [quiz_id], [date], [mark], [subject_id], [isSubmit]) VALUES (N'loi@giocong.com', N'1612362116973', CAST(N'2021-02-03 21:21:56.970' AS DateTime), 0, N'sj123', NULL)
INSERT [dbo].[QuizUser] ([email], [quiz_id], [date], [mark], [subject_id], [isSubmit]) VALUES (N'loi@giocong.com', N'1612362235156', CAST(N'2021-02-03 21:23:55.153' AS DateTime), 0, N'sj123', NULL)
INSERT [dbo].[QuizUser] ([email], [quiz_id], [date], [mark], [subject_id], [isSubmit]) VALUES (N'loi@giocong.com', N'1612362293595', CAST(N'2021-02-03 21:24:53.593' AS DateTime), 0, N'sj123', NULL)
INSERT [dbo].[QuizUser] ([email], [quiz_id], [date], [mark], [subject_id], [isSubmit]) VALUES (N'loi@giocong.com', N'1612362358318', CAST(N'2021-02-03 21:25:58.317' AS DateTime), 0, N'sj123', NULL)
INSERT [dbo].[QuizUser] ([email], [quiz_id], [date], [mark], [subject_id], [isSubmit]) VALUES (N'loi@giocong.com', N'1612365942867', CAST(N'2021-02-03 22:25:42.867' AS DateTime), 0, N'sj123', NULL)
INSERT [dbo].[QuizUser] ([email], [quiz_id], [date], [mark], [subject_id], [isSubmit]) VALUES (N'loi@giocong.com', N'1612366059484', CAST(N'2021-02-03 22:27:39.483' AS DateTime), 0, N'sj123', NULL)
INSERT [dbo].[SubjectDB] ([subject_id], [subject_name], [description]) VALUES (N'sj123', N'C Programming', N'There are a list of C language quizzes that will clear your C Basics, Expression, control statement, loops in C, functions, pre-processors, Pointers in C, Array in C, String handling, structures, uniona and enums in C concepts

We have categorized the C quizzes in Basics, Expression, Loops, Control statement, Loops, functions, pre-processors, pointers, array, String and Structure, Union & Enums.')
INSERT [dbo].[SubjectDB] ([subject_id], [subject_name], [description]) VALUES (N'sj124', N'C++ Programming', N'C++ is one of the common programming languages that most programmers are expected to have a good understanding on. As you continue your journey on this it is important to see if you already understand the basics and this quiz will help you do just that. Give it a shot and be a step closer to being perfect when it comes to this language.')
INSERT [dbo].[SubjectDB] ([subject_id], [subject_name], [description]) VALUES (N'sj125', N'Object Oriented Programming', N'As the name suggests, Object-Oriented Programming or OOPs refers to languages that use objects in programming. Object-oriented programming aims to implement real-world entities like inheritance, hiding, polymorphism, etc in programming. The main aim of OOP is to bind together the data and the functions that operate on them so that no other part of the code can access this data except that function.')
INSERT [dbo].[SubjectDB] ([subject_id], [subject_name], [description]) VALUES (N'sj126', N'C# Programming', N'There are many object-oriented programming (OOP) languages ​​on the market, and C# is one of the purest forms of the OOP language. C# is a Dot Net Framework''s programming language. This language was designed for both professionals and newbie programmers to start learning and implementing it.')
INSERT [dbo].[SubjectDB] ([subject_id], [subject_name], [description]) VALUES (N'sj127', N'JavaScript', N'JavaScript is used mainly for enhancing the interaction of a user with the webpage. In other words, you can make your webpage more lively and interactive, with the help of JavaScript. JavaScript is also being used widely in game development and Mobile application development.')
INSERT [dbo].[SubjectDB] ([subject_id], [subject_name], [description]) VALUES (N'sj128', N'Spring MVC', N'A Spring MVC is a Java framework which is used to build web applications. It follows the Model-View-Controller design pattern. It implements all the basic features of a core spring framework like Inversion of Control, Dependency Injection.

A Spring MVC provides an elegant solution to use MVC in spring framework by the help of DispatcherServlet. Here, DispatcherServlet is a class that receives the incoming request and maps it to the right resource such as controllers, models, and views.')
INSERT [dbo].[SubjectDB] ([subject_id], [subject_name], [description]) VALUES (N'sj129', N'PHP', N'PHP is one of the most widely used server side scripting language for web development. Popular websites like Facebook, Yahoo, Wikipedia etc, and our very own Studytonight, are developed using PHP.
PHP is so popular because it''s very simple to learn, code and deploy on server, hence it has been the first choice for beginners since decades.
')
INSERT [dbo].[SubjectDB] ([subject_id], [subject_name], [description]) VALUES (N'sj130', N'Python', NULL)
INSERT [dbo].[SubjectDB] ([subject_id], [subject_name], [description]) VALUES (N'sj131', N'Cloud Computing', NULL)
INSERT [dbo].[SubjectDB] ([subject_id], [subject_name], [description]) VALUES (N'sj132', N'Mongo DB', NULL)
INSERT [dbo].[SubjectDB] ([subject_id], [subject_name], [description]) VALUES (N'sj133', N'IoT ', NULL)
INSERT [dbo].[SubjectDB] ([subject_id], [subject_name], [description]) VALUES (N'sj134', N'MySQL', NULL)
INSERT [dbo].[SubjectDB] ([subject_id], [subject_name], [description]) VALUES (N'sj135', N'SQL Server', NULL)
INSERT [dbo].[SubjectDB] ([subject_id], [subject_name], [description]) VALUES (N'sj136', N'Cyber Security', NULL)
INSERT [dbo].[SubjectDB] ([subject_id], [subject_name], [description]) VALUES (N'sj137', N'Computer Fundamentals', NULL)
INSERT [dbo].[SubjectDB] ([subject_id], [subject_name], [description]) VALUES (N'sj138', N'Data Science', NULL)
INSERT [dbo].[SubjectDB] ([subject_id], [subject_name], [description]) VALUES (N'sj139', N'R Programming', NULL)
INSERT [dbo].[SubjectDB] ([subject_id], [subject_name], [description]) VALUES (N'sj140', N'Hadoop', NULL)
INSERT [dbo].[SubjectDB] ([subject_id], [subject_name], [description]) VALUES (N'sj141', N'Java Web', NULL)
INSERT [dbo].[SubjectDB] ([subject_id], [subject_name], [description]) VALUES (N'sj142', N'Java Desktop', NULL)
INSERT [dbo].[UserDB] ([email], [name], [password], [role], [status]) VALUES (N'fpt@fpt.edu.vn', N'Fpt Uni', N'123', 0, 1)
INSERT [dbo].[UserDB] ([email], [name], [password], [role], [status]) VALUES (N'loi@giocong.com', N'Quach Dai Loi', N'd760600308a5c272a5e0cffe0e08c84f864870dfff1055141ea87c77bc67247a', 0, 1)
INSERT [dbo].[UserDB] ([email], [name], [password], [role], [status]) VALUES (N'loi@gmail.com', N'Quach Dai Loi', N'123', 1, 1)
INSERT [dbo].[UserDB] ([email], [name], [password], [role], [status]) VALUES (N'quachdailoi2000@gmail.com', N'Quach Dai Loi', N'70f2871f09b7f811377643d60e0fffaae7ffc4029a0fe41aae211e94337a1f8c', 1, 1)
INSERT [dbo].[UserDB] ([email], [name], [password], [role], [status]) VALUES (N'quachdailoi2000@gmail.coms', N'Quach Dai Loi', N'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 0, 1)
USE [master]
GO
ALTER DATABASE [QuizOnlineDB] SET  READ_WRITE 
GO
