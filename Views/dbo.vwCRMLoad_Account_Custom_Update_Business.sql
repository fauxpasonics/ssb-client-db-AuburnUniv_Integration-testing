SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





CREATE  VIEW [dbo].[vwCRMLoad_Account_Custom_Update_Business]
AS
SELECT  
	 z.[crm_id] Id
	, b.[SSB_CRMSYSTEM_Contact_ID__c] 
	, b.[SSB_CRMSYSTEM_SSID_Winner__c] 
	, b.[SSB_CRMSYSTEM_SSID_Winner_SourceSystem__c] 
	, b.[SSB_CRMSYSTEM_SSID_TIX__c] 
	, b.[SSB_CRMSYSTEM_DimCustomerID__c] 
	, b.[AccountId] 
	, b.[CRMProcess_UpdatedDate]
		,b.SSB_CRMSYSTEM_Last_Ticket_Purchase_Date__c
	,b.SSB_CRMSYSTEM_Last_Donation_Date__c
	,b.SSB_CRMSYSTEM_Last_Adobe_Engagement_Date__c
	,b.Football_Full__c
	,b.Football_Partial__c
	,b.Football_Rookie__c
	,b.Men_s_Basketball_Full__c
	,b.Men_s_Basketball_Partial__c
	,b.Men_s_Basketball_Rookie__c
	,b.Business_Email__c
	,b.SSB_CRMSYSTEM_Customer_Type__c
	,b.PersonBirthdate
	,b.Priority_Points_Mens_Basketball__c
	,b.Priority_Points_Football__c
	,b.Priority_Points_Baseball__c
	,b.Patron_Status__c
	,b.[Customer_Status__c] 
	,b.[Donor_Type__c] 		
FROM dbo.[vwCRMLoad_Account_Std_Prep] a
INNER JOIN dbo.Contact_Custom b ON [a].[ssb_crmsystem_Contact_ID__c] = b.ssb_crmsystem_Contact_ID__c
INNER JOIN dbo.Contact z ON a.[ssb_crmsystem_Contact_ID__c] = z.ssb_crmsystem_Contact_ID
LEFT JOIN prodcopy.Account AA ON z.crm_ID = aa.ID
LEFT JOIN prodcopy.RecordType rt ON aa.RecordTypeId = rt.Id
WHERE z.[SSB_CRMSYSTEM_Contact_ID] <> z.[crm_id]
AND rt.name = 'Business Account' --Added TCF 6/5/17 in place of line below
--AND ISNULL(CASE WHEN rt.name = 'Business_Account' THEN 1 WHEN rt.name = 'PersonAccount' THEN 0 END, z.isbusinessaccount) = 1
AND (1=2
	OR ISNULL(b.[SSB_CRMSYSTEM_SSID_Winner__c],'') != ISNULL(aa.[SSB_CRMSYSTEM_SSID_Winner__c],'')
	OR ISNULL(b.[SSB_CRMSYSTEM_SSID_Winner_SourceSystem__c],'') != ISNULL(aa.[SSB_CRMSYSTEM_SSID_Winner_SourceSystem__c],'')
	OR ISNULL(b.[SSB_CRMSYSTEM_SSID_TIX__c],'') != ISNULL(aa.SSB_CRMSYSTEM_SSID_Paciolan__c,'')
	OR ISNULL(b.[SSB_CRMSYSTEM_DimCustomerID__c],'') != ISNULL(aa.[SSB_CRMSYSTEM_DimCustomerID__c],'')
	OR ISNULL(b.AccountID,'') != ISNULL(aa.patron_id__c,'')
		OR ISNULL(b.SSB_CRMSYSTEM_Last_Ticket_Purchase_Date__c,'') != ISNULL(aa.SSB_CRMSYSTEM_Last_Ticket_Purchase_Date__c,'')
	OR ISNULL(b.SSB_CRMSYSTEM_Last_Donation_Date__c,'') != ISNULL(aa.SSB_CRMSYSTEM_Last_Donation_Date__c,'')
	OR ISNULL(CAST(b.SSB_CRMSYSTEM_Last_Adobe_Engagement_Date__c AS DATE),'') != ISNULL(aa.SSB_CRMSYSTEM_Last_Adobe_Engagement_Date__c,'')
	OR ISNULL(b.Football_Full__c,'') != ISNULL(aa.Football_Full__c,'')
	OR ISNULL(b.Football_Partial__c,'') != ISNULL(aa.Football_Partial__c,'')
	OR ISNULL(b.Football_Rookie__c,'') != ISNULL(aa.Football_Rookie__c,'')
	OR ISNULL(b.Men_s_Basketball_Full__c,'') != ISNULL(aa.Men_s_Basketball_Full__c,'')
	OR ISNULL(b.Men_s_Basketball_Partial__c,'') != ISNULL(aa.Men_s_Basketball_Partial__c,'')
	OR ISNULL(b.Men_s_Basketball_Rookie__c,'') != ISNULL(aa.Men_s_Basketball_Rookie__c,'')
	OR ISNULL(b.Business_Email__c,'') != ISNULL(aa.Business_Email__c,'')
	OR ISNULL(b.SSB_CRMSYSTEM_Customer_Type__c,'') != ISNULL(aa.SSB_CRMSYSTEM_Customer_Type__c,'')
	OR ISNULL(b.PersonBirthdate,'') != ISNULL(aa.PersonBirthdate,'')
	OR ISNULL(CAST(b.Priority_Points_Mens_Basketball__c AS NVARCHAR(100)),'') != ISNULL(aa.Priority_Points_Mens_Basketball__c,'')
	OR ISNULL(CAST(b.Priority_Points_Football__c AS NVARCHAR(100)),'') != ISNULL(aa.Priority_Points_Football__c,'')
	OR ISNULL(CAST(b.Priority_Points_Baseball__c AS NVARCHAR(100)),'') != ISNULL(aa.Priority_Points_Baseball__c,'')
	OR ISNULL(CAST(b.Patron_Status__c AS NVARCHAR(100)),'') != ISNULL(aa.Patron_Status__c,'')
	OR ISNULL(CAST(b.[Customer_Status__c] AS NVARCHAR(100)),'') != ISNULL(aa.[Customer_Status__c],'')
	OR ISNULL(CAST(b.[Donor_Type__c] AS NVARCHAR(100)),'') != ISNULL(aa.[Donor_Type__c],'')
	

	)




GO
