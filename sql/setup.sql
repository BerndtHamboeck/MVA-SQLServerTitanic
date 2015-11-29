use master;
go
CREATE DATABASE [sqlr];
go
use sqlr;
go
drop table if exists TitanicTrain;
go

//1,0,3,"Braund, Mr. Owen Harris",male,22,1,0,A/5 21171,7.25,,S

-- create the training table:
CREATE TABLE [dbo].[TitanicTrain](
	[PassengerId] [int] NOT NULL,
	[Survived] [bit] NOT NULL,
	[Pclass] [int] NULL,
	[Name] [varchar](250) NULL,
	[Sex] [varchar](50) NULL,
	[Age] [decimal](4, 2) NULL,
	[SibSp] [int] NULL,
	[Parch] [int] NULL,
	[Ticket] [varchar](50) NULL,
	[Fare] [decimal](10, 2) NULL,
	[Cabin] [varchar](50) NULL,
	[Embarked] [varchar](50) NULL,
 CONSTRAINT [PK_TitanicTrain] PRIMARY KEY CLUSTERED ([PassengerId] ASC) 

go
