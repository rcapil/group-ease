USE [GroupEase]
GO
/****** Object:  Table [dbo].[Activity]    Script Date: 6/15/2016 11:04:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Activity](
	[activityId] [uniqueidentifier] NOT NULL,
	[title] [nvarchar](255) NOT NULL,
	[description] [nvarchar](max) NULL,
	[isPrivate] [bit] NOT NULL,
	[date] [datetime2](7) NOT NULL,
	[createdDate] [datetime2](7) NOT NULL,
	[modifiedDate] [datetime2](7) NULL,
 CONSTRAINT [PK_Activity] PRIMARY KEY CLUSTERED 
(
	[activityId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Member]    Script Date: 6/15/2016 11:04:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Member](
	[memberId] [int] IDENTITY(1,1) NOT NULL,
	[userId] [int] NOT NULL,
	[activityId] [uniqueidentifier] NOT NULL,
	[isOrganizer] [bit] NOT NULL,
 CONSTRAINT [PK_Member] PRIMARY KEY CLUSTERED 
(
	[memberId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Message]    Script Date: 6/15/2016 11:04:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Message](
	[messageId] [int] IDENTITY(1,1) NOT NULL,
	[activityId] [uniqueidentifier] NOT NULL,
	[userId] [int] NOT NULL,
	[body] [nvarchar](max) NULL,
	[timestamp] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Message] PRIMARY KEY CLUSTERED 
(
	[messageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Question]    Script Date: 6/15/2016 11:04:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Question](
	[questionId] [int] IDENTITY(1,1) NOT NULL,
	[text] [nvarchar](1000) NOT NULL,
	[modifiedDate] [datetime2](7) NULL,
 CONSTRAINT [PK_Question] PRIMARY KEY CLUSTERED 
(
	[questionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[QuestionOrder]    Script Date: 6/15/2016 11:04:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QuestionOrder](
	[questionId] [int] NOT NULL,
	[surveyId] [int] NOT NULL,
	[sortOrder] [int] NULL,
 CONSTRAINT [PK_QuestionOrder] PRIMARY KEY CLUSTERED 
(
	[questionId] ASC,
	[surveyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[QuestionType]    Script Date: 6/15/2016 11:04:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[QuestionType](
	[typeId] [int] IDENTITY(1,1) NOT NULL,
	[questionId] [int] NOT NULL,
	[name] [varchar](30) NOT NULL,
 CONSTRAINT [PK_QuestionType] PRIMARY KEY CLUSTERED 
(
	[typeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Response]    Script Date: 6/15/2016 11:04:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Response](
	[surveyResponseId] [int] NOT NULL,
	[questionId] [int] NOT NULL,
	[userId] [int] NOT NULL,
	[answer] [nvarchar](1000) NOT NULL,
 CONSTRAINT [PK_Response] PRIMARY KEY CLUSTERED 
(
	[surveyResponseId] ASC,
	[questionId] ASC,
	[userId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ResponseChoice]    Script Date: 6/15/2016 11:04:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ResponseChoice](
	[responseChoiceId] [int] IDENTITY(1,1) NOT NULL,
	[questionId] [int] NOT NULL,
	[text] [varchar](1000) NOT NULL,
 CONSTRAINT [PK_ResponseChoice] PRIMARY KEY CLUSTERED 
(
	[responseChoiceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Survey]    Script Date: 6/15/2016 11:04:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Survey](
	[surveyId] [int] IDENTITY(1,1) NOT NULL,
	[activityId] [uniqueidentifier] NOT NULL,
	[name] [nvarchar](255) NOT NULL,
	[description] [nvarchar](max) NULL,
	[createdDate] [datetime2](7) NOT NULL,
	[modifiedDate] [datetime2](7) NULL,
 CONSTRAINT [PK_Survey] PRIMARY KEY CLUSTERED 
(
	[surveyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SurveyResponse]    Script Date: 6/15/2016 11:04:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SurveyResponse](
	[surveyResponseId] [int] IDENTITY(1,1) NOT NULL,
	[userId] [int] NOT NULL,
	[surveyId] [int] NOT NULL,
	[modifiedDate] [datetime2](7) NULL,
 CONSTRAINT [PK_SurveyResponse] PRIMARY KEY CLUSTERED 
(
	[surveyResponseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Task]    Script Date: 6/15/2016 11:04:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Task](
	[taskId] [int] IDENTITY(1,1) NOT NULL,
	[userId] [int] NOT NULL,
	[activityId] [uniqueidentifier] NOT NULL,
	[title] [nvarchar](255) NOT NULL,
	[description] [nvarchar](max) NULL,
	[dueDate] [datetime2](7) NOT NULL,
	[isComplete] [bit] NOT NULL,
	[createDate] [datetime2](7) NOT NULL,
	[modifiedDate] [datetime2](7) NULL,
 CONSTRAINT [PK_Task] PRIMARY KEY CLUSTERED 
(
	[taskId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[User]    Script Date: 6/15/2016 11:04:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[User](
	[userId] [int] IDENTITY(1,1) NOT NULL,
	[userName] [nvarchar](255) NOT NULL,
	[firstName] [nvarchar](255) NULL,
	[lastName] [nvarchar](255) NULL,
	[email] [nvarchar](255) NOT NULL,
	[salt] [varchar](255) NOT NULL,
	[saltedHash] [varchar](255) NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[userId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Member]  WITH CHECK ADD  CONSTRAINT [FK_Member_Activity] FOREIGN KEY([activityId])
REFERENCES [dbo].[Activity] ([activityId])
GO
ALTER TABLE [dbo].[Member] CHECK CONSTRAINT [FK_Member_Activity]
GO
ALTER TABLE [dbo].[Member]  WITH CHECK ADD  CONSTRAINT [FK_Member_User] FOREIGN KEY([userId])
REFERENCES [dbo].[User] ([userId])
GO
ALTER TABLE [dbo].[Member] CHECK CONSTRAINT [FK_Member_User]
GO
ALTER TABLE [dbo].[Message]  WITH CHECK ADD  CONSTRAINT [FK_Message_Activity] FOREIGN KEY([activityId])
REFERENCES [dbo].[Activity] ([activityId])
GO
ALTER TABLE [dbo].[Message] CHECK CONSTRAINT [FK_Message_Activity]
GO
ALTER TABLE [dbo].[Message]  WITH CHECK ADD  CONSTRAINT [FK_Message_User] FOREIGN KEY([userId])
REFERENCES [dbo].[User] ([userId])
GO
ALTER TABLE [dbo].[Message] CHECK CONSTRAINT [FK_Message_User]
GO
ALTER TABLE [dbo].[QuestionOrder]  WITH CHECK ADD  CONSTRAINT [FK_QuestionOrder_Question] FOREIGN KEY([questionId])
REFERENCES [dbo].[Question] ([questionId])
GO
ALTER TABLE [dbo].[QuestionOrder] CHECK CONSTRAINT [FK_QuestionOrder_Question]
GO
ALTER TABLE [dbo].[QuestionOrder]  WITH CHECK ADD  CONSTRAINT [FK_QuestionOrder_Survey] FOREIGN KEY([surveyId])
REFERENCES [dbo].[Survey] ([surveyId])
GO
ALTER TABLE [dbo].[QuestionOrder] CHECK CONSTRAINT [FK_QuestionOrder_Survey]
GO
ALTER TABLE [dbo].[QuestionType]  WITH CHECK ADD  CONSTRAINT [FK_QuestionType_Question] FOREIGN KEY([questionId])
REFERENCES [dbo].[Question] ([questionId])
GO
ALTER TABLE [dbo].[QuestionType] CHECK CONSTRAINT [FK_QuestionType_Question]
GO
ALTER TABLE [dbo].[Response]  WITH CHECK ADD  CONSTRAINT [FK_Response_Question] FOREIGN KEY([questionId])
REFERENCES [dbo].[Question] ([questionId])
GO
ALTER TABLE [dbo].[Response] CHECK CONSTRAINT [FK_Response_Question]
GO
ALTER TABLE [dbo].[Response]  WITH CHECK ADD  CONSTRAINT [FK_Response_SurveyResponse] FOREIGN KEY([surveyResponseId])
REFERENCES [dbo].[SurveyResponse] ([surveyResponseId])
GO
ALTER TABLE [dbo].[Response] CHECK CONSTRAINT [FK_Response_SurveyResponse]
GO
ALTER TABLE [dbo].[Response]  WITH CHECK ADD  CONSTRAINT [FK_Response_User] FOREIGN KEY([userId])
REFERENCES [dbo].[User] ([userId])
GO
ALTER TABLE [dbo].[Response] CHECK CONSTRAINT [FK_Response_User]
GO
ALTER TABLE [dbo].[ResponseChoice]  WITH CHECK ADD  CONSTRAINT [FK_ResponseChoice_Question] FOREIGN KEY([questionId])
REFERENCES [dbo].[Question] ([questionId])
GO
ALTER TABLE [dbo].[ResponseChoice] CHECK CONSTRAINT [FK_ResponseChoice_Question]
GO
ALTER TABLE [dbo].[Survey]  WITH CHECK ADD  CONSTRAINT [FK_Survey_Activity] FOREIGN KEY([activityId])
REFERENCES [dbo].[Activity] ([activityId])
GO
ALTER TABLE [dbo].[Survey] CHECK CONSTRAINT [FK_Survey_Activity]
GO
ALTER TABLE [dbo].[SurveyResponse]  WITH CHECK ADD  CONSTRAINT [FK_SurveyResponse_Survey] FOREIGN KEY([surveyId])
REFERENCES [dbo].[Survey] ([surveyId])
GO
ALTER TABLE [dbo].[SurveyResponse] CHECK CONSTRAINT [FK_SurveyResponse_Survey]
GO
ALTER TABLE [dbo].[SurveyResponse]  WITH CHECK ADD  CONSTRAINT [FK_SurveyResponse_User] FOREIGN KEY([userId])
REFERENCES [dbo].[User] ([userId])
GO
ALTER TABLE [dbo].[SurveyResponse] CHECK CONSTRAINT [FK_SurveyResponse_User]
GO
ALTER TABLE [dbo].[Task]  WITH CHECK ADD  CONSTRAINT [FK_Task_Activity] FOREIGN KEY([activityId])
REFERENCES [dbo].[Activity] ([activityId])
GO
ALTER TABLE [dbo].[Task] CHECK CONSTRAINT [FK_Task_Activity]
GO
ALTER TABLE [dbo].[Task]  WITH CHECK ADD  CONSTRAINT [FK_Task_User] FOREIGN KEY([userId])
REFERENCES [dbo].[User] ([userId])
GO
ALTER TABLE [dbo].[Task] CHECK CONSTRAINT [FK_Task_User]
GO
