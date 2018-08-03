SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [dbo].[vwCRMLoad_Account_Custom_Update]
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
	, b.[PersonOtherPhone]
	, b.[PersonEmail] 
	, b.[PersonHomePhone]
	,z.AddressPrimaryStreet	PersonMailingStreet
	,z.AddressPrimaryCity	PersonMailingCity
	,z.AddressPrimaryState	PersonMailingState
	,z.AddressPrimaryZip	PersonMailingPostalCode
	,z.AddressPrimaryCountry PersonMailingCountry
FROM dbo.[vwCRMLoad_Account_Std_Prep] a
INNER JOIN dbo.Contact_Custom b ON [a].[ssb_crmsystem_Contact_ID__c] = b.ssb_crmsystem_Contact_ID__c
INNER JOIN dbo.Contact z ON a.[ssb_crmsystem_Contact_ID__c] = z.ssb_crmsystem_Contact_ID
WHERE z.[SSB_CRMSYSTEM_CONTACT_ID] <> z.[crm_id]






GO
