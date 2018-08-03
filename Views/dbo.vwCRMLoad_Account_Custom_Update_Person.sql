SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





CREATE VIEW [dbo].[vwCRMLoad_Account_Custom_Update_Person]
AS
SELECT  
--b.ssb_crmsystem_Contact_ID,
	 z.[crm_id] Id
	, b.[SSB_CRMSYSTEM_Contact_ID__c] 												  --,aa.[SSB_CRMSYSTEM_Contact_ID__c]
	, b.[SSB_CRMSYSTEM_SSID_Winner__c] 												  --,aa.[SSB_CRMSYSTEM_SSID_Winner__c]
	, b.[SSB_CRMSYSTEM_SSID_Winner_SourceSystem__c] 								  --,aa.[SSB_CRMSYSTEM_SSID_Winner_SourceSystem__c]
	, LEFT(b.[SSB_CRMSYSTEM_SSID_TIX__c],255) AS  [SSB_CRMSYSTEM_SSID_TIX__c]		  --,aa.SSB_CRMSYSTEM_SSID_Paciolan__c
	, b.[SSB_CRMSYSTEM_DimCustomerID__c] 											  --,aa.[SSB_CRMSYSTEM_DimCustomerID__c]
	, LEFT(b.[AccountId],255) AS AccountID 											  --,aa.patron_id__c
	, b.[CRMProcess_UpdatedDate]													  --
	, b.[PersonOtherPhone]															  --,aa.[PersonOtherPhone]
	, b.[PersonEmail] 																  --,aa.[PersonEmail]
	, b.[PersonHomePhone]															  --,aa.[PersonHomePhone]
	,z.AddressPrimaryStreet	PersonMailingStreet										  --,aa.PersonMailingStreet
	,z.AddressPrimaryCity	PersonMailingCity										  --,aa.PersonMailingCity
	,z.AddressPrimaryState	PersonMailingState										  --,aa.PersonMailingState
	,z.AddressPrimaryZip	PersonMailingPostalCode									  --,aa.PersonMailingPostalCode
	,z.AddressPrimaryCountry PersonMailingCountry									  --,aa.PersonMailingCountry
	,b.SSB_CRMSYSTEM_Last_Ticket_Purchase_Date__c									  --,aa.SSB_CRMSYSTEM_Last_Ticket_Purchase_Date__c		
	,b.SSB_CRMSYSTEM_Last_Donation_Date__c											  --,aa.SSB_CRMSYSTEM_Last_Donation_Date__c				
	,b.SSB_CRMSYSTEM_Last_Adobe_Engagement_Date__c									  --,aa.SSB_CRMSYSTEM_Last_Adobe_Engagement_Date__c		
	,b.Football_Full__c																  --,aa.Football_Full__c									
	,b.Football_Partial__c															  --,aa.Football_Partial__c								
	,b.Football_Rookie__c															  --,aa.Football_Rookie__c								
	,b.Men_s_Basketball_Full__c														  --,aa.Men_s_Basketball_Full__c							
	,b.Men_s_Basketball_Partial__c													  --,aa.Men_s_Basketball_Partial__c						
	,b.Men_s_Basketball_Rookie__c													  --,aa.Men_s_Basketball_Rookie__c						
	,b.Business_Email__c															  --,aa.Business_Email__c								
	,b.SSB_CRMSYSTEM_Customer_Type__c												  --,aa.SSB_CRMSYSTEM_Customer_Type__c					
	,b.PersonBirthdate																  --,aa.PersonBirthdate									
	,b.Priority_Points_Mens_Basketball__c											  --,aa.Priority_Points_Mens_Basketball__c				
	,b.Priority_Points_Football__c													  --,aa.Priority_Points_Football__c						
	,b.Priority_Points_Baseball__c													  --,aa.Priority_Points_Baseball__c						
	, b.Patron_Status__c															  --,aa.Patron_Status__c								
	,b.[Customer_Status__c] 														  --,aa.[Customer_Status__c] 							
    ,b.[Donor_Type__c] 																  --,aa.[Donor_Type__c] 		
	
	
	--,case when ISNULL(b.[SSB_CRMSYSTEM_SSID_Winner__c],'') != ISNULL(aa.[SSB_CRMSYSTEM_SSID_Winner__c],'')											 then 1 else 0 end as [SSB_CRMSYSTEM_SSID_Winner__c] 
	--,case when ISNULL(b.[SSB_CRMSYSTEM_SSID_Winner_SourceSystem__c],'') != ISNULL(aa.[SSB_CRMSYSTEM_SSID_Winner_SourceSystem__c],'')					 then 1 else 0 end as [SSB_CRMSYSTEM_SSID_Winner_SourceSystem__c] 
	--,case when ISNULL(b.[SSB_CRMSYSTEM_SSID_TIX__c],'') != ISNULL(aa.SSB_CRMSYSTEM_SSID_Paciolan__c,'')												 then 1 else 0 end as [SSB_CRMSYSTEM_SSID_TIX__c] 
	--,case when ISNULL(b.[SSB_CRMSYSTEM_DimCustomerID__c],'') != ISNULL(aa.[SSB_CRMSYSTEM_DimCustomerID__c],'')										 then 1 else 0 end as [SSB_CRMSYSTEM_DimCustomerID__c] 
	--,case when ISNULL(b.AccountID,'') != ISNULL(aa.patron_id__c,'')																					 then 1 else 0 end as AccountID 
	--,case when ISNULL(b.[PersonOtherPhone],'') != ISNULL(aa.[PersonOtherPhone],'')																	 then 1 else 0 end as [PersonOtherPhone]  
	--,case when ISNULL(b.[PersonEmail],'') != ISNULL(aa.[PersonEmail],'')																				 then 1 else 0 end as [PersonEmail] 
	--,case when ISNULL(b.[PersonHomePhone],'') != ISNULL(aa.[PersonHomePhone],'')																		 then 1 else 0 end as [PersonHomePhone] 
	--,case when ISNULL(z.AddressPrimaryStreet,'') != ISNULL(aa.PersonMailingStreet,'')																 then 1 else 0 end as PersonMailingStreet 
	--,case when ISNULL(z.AddressPrimaryCity,'') != ISNULL(aa.PersonMailingCity,'')																	 then 1 else 0 end as PersonMailingCity 
	--,case when ISNULL(z.AddressPrimaryState,'') != ISNULL(aa.PersonMailingState,'')																	 then 1 else 0 end as PersonMailingState 
	--,case when ISNULL(z.AddressPrimaryZip,'') != ISNULL(aa.PersonMailingPostalCode,'')																 then 1 else 0 end as PersonMailingPostalCode 
	--,case when ISNULL(z.AddressPrimaryCountry,'') != ISNULL(aa.PersonMailingCountry,'')																 then 1 else 0 end as PersonMailingCountry 
	--,case when ISNULL(b.SSB_CRMSYSTEM_Last_Ticket_Purchase_Date__c,'') != ISNULL(aa.SSB_CRMSYSTEM_Last_Ticket_Purchase_Date__c,'')					 then 1 else 0 end as SSB_CRMSYSTEM_Last_Ticket_Purchase_Date__c	 
	--,case when ISNULL(b.SSB_CRMSYSTEM_Last_Donation_Date__c,'') != ISNULL(aa.SSB_CRMSYSTEM_Last_Donation_Date__c,'')									 then 1 else 0 end as SSB_CRMSYSTEM_Last_Donation_Date__c			 
	--,case when ISNULL(CAST(b.SSB_CRMSYSTEM_Last_Adobe_Engagement_Date__c AS DATE),'') != ISNULL(aa.SSB_CRMSYSTEM_Last_Adobe_Engagement_Date__c,'')					 then 1 else 0 end as SSB_CRMSYSTEM_Last_Adobe_Engagement_Date__c	 	
	--,case when ISNULL(b.Football_Full__c,'') != ISNULL(aa.Football_Full__c,'')																		 then 1 else 0 end as Football_Full__c								 	
	--,case when ISNULL(b.Football_Partial__c,'') != ISNULL(aa.Football_Partial__c,'')																	 then 1 else 0 end as Football_Partial__c							 	
	--,case when ISNULL(b.Football_Rookie__c,'') != ISNULL(aa.Football_Rookie__c,'')																	 then 1 else 0 end as Football_Rookie__c							 	
	--,case when ISNULL(b.Men_s_Basketball_Full__c,'') != ISNULL(aa.Men_s_Basketball_Full__c,'')														 then 1 else 0 end as Men_s_Basketball_Full__c						 	
	--,case when ISNULL(b.Men_s_Basketball_Partial__c,'') != ISNULL(aa.Men_s_Basketball_Partial__c,'')													 then 1 else 0 end as Men_s_Basketball_Partial__c					 	
	--,case when ISNULL(b.Men_s_Basketball_Rookie__c,'') != ISNULL(aa.Men_s_Basketball_Rookie__c,'')													 then 1 else 0 end as Men_s_Basketball_Rookie__c					 	
	--,case when ISNULL(b.Business_Email__c,'') != ISNULL(aa.Business_Email__c,'')																		 then 1 else 0 end as Business_Email__c							 		
	--,case when ISNULL(b.SSB_CRMSYSTEM_Customer_Type__c,'') != ISNULL(aa.SSB_CRMSYSTEM_Customer_Type__c,'')											 then 1 else 0 end as SSB_CRMSYSTEM_Customer_Type__c				 
	--,case when ISNULL(b.PersonBirthdate,'') != ISNULL(aa.PersonBirthdate,'')																			 then 1 else 0 end as PersonBirthdate								 	
	--,case when ISNULL(CAST(b.Priority_Points_Mens_Basketball__c AS NVARCHAR(100)),'') != ISNULL(aa.Priority_Points_Mens_Basketball__c,'')			 then 1 else 0 end as Priority_Points_Mens_Basketball__c			 	
	--,case when ISNULL(CAST(b.Priority_Points_Football__c AS NVARCHAR(100)),'') != ISNULL(aa.Priority_Points_Football__c,'')							 then 1 else 0 end as Priority_Points_Football__c					 	
	--,case when ISNULL(CAST(b.Priority_Points_Baseball__c AS NVARCHAR(100)),'') != ISNULL(aa.Priority_Points_Baseball__c,'')							 then 1 else 0 end as Priority_Points_Baseball__c					 	
	--,case when ISNULL(CAST(b.Patron_Status__c AS NVARCHAR(100)),'') != ISNULL(aa.Patron_Status__c,'')												 then 1 else 0 end as Patron_Status__c								 	
	--,case when ISNULL(CAST(b.[Customer_Status__c] AS NVARCHAR(100)),'') != ISNULL(aa.[Customer_Status__c],'')										 then 1 else 0 end as [Customer_Status__c] 						 	
	--,case when ISNULL(CAST(b.[Donor_Type__c] AS NVARCHAR(100)),'') != ISNULL(aa.[Donor_Type__c],'')													 then 1 else 0 end as [Donor_Type__c] 		 	
																																										   
FROM dbo.[vwCRMLoad_Account_Std_Prep] a																																	 
INNER JOIN dbo.Contact_Custom b ON [a].[ssb_crmsystem_Contact_ID__c] = b.ssb_crmsystem_Contact_ID__c
INNER JOIN dbo.Contact z ON a.[ssb_crmsystem_Contact_ID__c] = z.ssb_crmsystem_Contact_ID
LEFT JOIN prodcopy.Account AA ON z.crm_ID = aa.ID
LEFT JOIN prodcopy.RecordType rt ON aa.RecordTypeId = rt.Id
WHERE z.[SSB_CRMSYSTEM_Contact_ID] <> z.[crm_id]
AND ISNULL(CASE WHEN rt.name = 'Business Account' THEN 1 WHEN rt.name = 'Person Account' THEN 0 END, z.isbusinessaccount) = 0 
AND (1=2
	OR ISNULL(b.[SSB_CRMSYSTEM_SSID_Winner__c],'') != ISNULL(aa.[SSB_CRMSYSTEM_SSID_Winner__c],'')
	OR ISNULL(b.[SSB_CRMSYSTEM_SSID_Winner_SourceSystem__c],'') != ISNULL(aa.[SSB_CRMSYSTEM_SSID_Winner_SourceSystem__c],'')
	OR ISNULL(b.[SSB_CRMSYSTEM_SSID_TIX__c],'') != ISNULL(aa.SSB_CRMSYSTEM_SSID_Paciolan__c,'')
	OR ISNULL(b.[SSB_CRMSYSTEM_DimCustomerID__c],'') != ISNULL(aa.[SSB_CRMSYSTEM_DimCustomerID__c],'')
	OR ISNULL(b.AccountID,'') != ISNULL(aa.patron_id__c,'')
	OR ISNULL(b.[PersonOtherPhone],'') != ISNULL(aa.[PersonOtherPhone],'')
	OR ISNULL(b.[PersonEmail],'') != ISNULL(aa.[PersonEmail],'')
	OR ISNULL(b.[PersonHomePhone],'') != ISNULL(aa.[PersonHomePhone],'')
	OR ISNULL(z.AddressPrimaryStreet,'') != ISNULL(aa.PersonMailingStreet,'')
	OR ISNULL(z.AddressPrimaryCity,'') != ISNULL(aa.PersonMailingCity,'')
	OR ISNULL(z.AddressPrimaryState,'') != ISNULL(aa.PersonMailingState,'')
	OR ISNULL(z.AddressPrimaryZip,'') != ISNULL(aa.PersonMailingPostalCode,'')
	OR ISNULL(z.AddressPrimaryCountry,'') != ISNULL(aa.PersonMailingCountry,'')
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
