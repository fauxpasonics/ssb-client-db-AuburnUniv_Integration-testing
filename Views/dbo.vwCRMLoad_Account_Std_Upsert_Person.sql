SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





CREATE VIEW [dbo].[vwCRMLoad_Account_Std_Upsert_Person] AS
SELECT --top 1

ssb_crmsystem_Contact_ID__c, a.FirstName, a.LastName ,a.Suffix, 
 BillingStreet, BillingCity, BillingState, BillingPostalCode, BillingCountry, a.Phone, [LoadType]
 , CASE WHEN b.IsBusinessAccount = 1 THEN '01246000000TdimAAC' ELSE '01246000000TdirAAC' END RecordTypeId --updateme
 , a.Name AS FullName__c
FROM [dbo].[vwCRMLoad_Account_Std_Prep] a
JOIN dbo.Contact b ON a.ssb_crmsystem_Contact_ID__c = b.ssb_crmsystem_Contact_ID
WHERE LoadType = 'Upsert' AND b.IsBusinessAccount = 0





GO
