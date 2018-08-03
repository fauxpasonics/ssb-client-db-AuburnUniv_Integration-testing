CREATE TABLE [dbo].[Contact_Custom]
(
[SSB_CRMSYSTEM_Contact_ID__c] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SSB_CRMSYSTEM_SSID_Winner__c] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SSB_CRMSYSTEM_SSID_Winner_SourceSystem__c] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SSB_CRMSYSTEM_SSID_TIX__c] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SSB_CRMSYSTEM_DimCustomerID__c] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AccountId] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CRMProcess_UpdatedDate] [datetime] NULL,
[PersonOtherPhone] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PersonEmail] [varchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PersonHomePhone] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SSB_CRMSYSTEM_Last_Ticket_Purchase_Date__c] [datetime] NULL,
[SSB_CRMSYSTEM_Last_Donation_Date__c] [datetime] NULL,
[SSB_CRMSYSTEM_Last_Adobe_Engagement_Date__c] [datetime] NULL,
[Football_Full__c] [bit] NULL,
[Football_Partial__c] [bit] NULL,
[Football_Rookie__c] [bit] NULL,
[Men_s_Basketball_Full__c] [bit] NULL,
[Men_s_Basketball_Partial__c] [bit] NULL,
[Men_s_Basketball_Rookie__c] [bit] NULL,
[Business_Email__c] [nvarchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SSB_CRMSYSTEM_Customer_Type__c] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PersonBirthdate] [date] NULL,
[Priority_Points_Mens_Basketball__c] [decimal] (16, 2) NULL,
[Priority_Points_Football__c] [decimal] (16, 2) NULL,
[Priority_Points_Baseball__c] [decimal] (16, 2) NULL,
[Patron_Status__c] [nvarchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Donor_Type__c] [nvarchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Customer_Status__c] [nvarchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [dbo].[Contact_Custom] ADD CONSTRAINT [PK_Contact_Custom] PRIMARY KEY CLUSTERED  ([SSB_CRMSYSTEM_Contact_ID__c])
GO
