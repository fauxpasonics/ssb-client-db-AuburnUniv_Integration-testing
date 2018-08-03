SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO







CREATE PROCEDURE [wrk].[sp_Contact_Custom]
AS 

--TRUNCATE TABLE dbo.Contact_Custom;

MERGE INTO dbo.Contact_Custom Target
USING dbo.[Contact] source
ON source.[SSB_CRMSYSTEM_Contact_ID] = target.[SSB_CRMSYSTEM_Contact_ID__c]
WHEN NOT MATCHED BY TARGET THEN
INSERT ([SSB_CRMSYSTEM_Contact_ID__c]) VALUES (Source.[SSB_CRMSYSTEM_Contact_ID])
WHEN NOT MATCHED BY SOURCE THEN DELETE;

EXEC dbo.sp_CRMProcess_ConcatIDs 'Contact'




UPDATE a
SET [SSB_CRMSYSTEM_SSID_Winner__c] = b.SSID
	,[a].[SSB_CRMSYSTEM_SSID_Winner_SourceSystem__c] = b.SourceSystem
	,[PersonHomePhone] = b.PhoneHome
	,[PersonOtherPhone] = b.PhoneOther
	,[PersonEmail] = b.EmailOne
	,[Business_Email__c] = b.EmailOne
	,[PersonBirthdate] = b.Birthday
	,[SSB_CRMSYSTEM_Customer_Type__c] = b.CustomerType
	,[Patron_Status__c] = CASE WHEN b.SourceSystem = 'Paciolan' THEN b.ExtAttribute2 ELSE NULL END 
	,[Donor_Type__c]  = CASE WHEN b.SourceSystem = 'Paciolan' THEN b.ExtAttribute3 ELSE NULL END 
	,[Customer_Status__c] = CASE WHEN b.SourceSystem = 'Paciolan' THEN b.CustomerStatus ELSE NULL END 
	
FROM [dbo].[Contact_Custom] a (NOLOCK)
INNER JOIN dbo.[vwCompositeRecord_ModAcctID] b ON b.[SSB_CRMSYSTEM_CONTACT_ID] = [a].[SSB_CRMSYSTEM_Contact_ID__c]
INNER JOIN dbo.[vwDimCustomer_ModAcctId] c ON b.[DimCustomerId] = c.[DimCustomerId] AND c.SSB_CRMSYSTEM_PRIMARY_FLAG = 1


DECLARE @currentmemberyear INT = (SELECT  DATEPART(YEAR,GETDATE()))
					
DECLARE @previousmemberyear INT = @currentmemberyear -1 

---------------------------------------------------------------------------------
----------------- PACIOLAN FIELDS -----------------------------------------------
---------------------------------------------------------------------------------

-- For Last_Ticket_Purchase_Date
UPDATE a
SET [SSB_CRMSYSTEM_Last_Ticket_Purchase_Date__c]= odet.Ticket_Date
FROM [dbo].[Contact_Custom] a (NOLOCK)
INNER JOIN (SELECT [b].[SSB_CRMSYSTEM_Contact_ID],MAX([I_DATE]) AS Ticket_Date FROM [AuburnUniv].[dbo].[TK_ODET] a (NOLOCK)
			INNER JOIN dbo.[vwDimCustomer_ModAcctId] b ON [a].CUSTOMER = b.SSID AND b.SourceSystem = 'Paciolan'
			GROUP BY [b].[SSB_CRMSYSTEM_Contact_ID])odet
ON odet.[SSB_CRMSYSTEM_Contact_ID]=a.[SSB_CRMSYSTEM_Contact_ID__c] 

-- For Last_Donation_date
UPDATE a
SET [SSB_CRMSYSTEM_Last_Donation_Date__c] = fd.Donation_Date
FROM [dbo].[Contact_Custom] a (NOLOCK)
INNER JOIN (SELECT [b].[SSB_CRMSYSTEM_Contact_ID],MAX([DATE]) AS Donation_Date FROM  [AuburnUniv].[ro].[vw__Donation_Detail] a
			INNER JOIN dbo.[vwDimCustomer_ModAcctId] b ON [a].DONOR = b.SSID AND b.SourceSystem = 'Paciolan'
			WHERE CASH_AMT > '0'
			GROUP BY [b].[SSB_CRMSYSTEM_Contact_ID])fd 
ON  fd.[SSB_CRMSYSTEM_Contact_ID] = a.[SSB_CRMSYSTEM_Contact_ID__c] 


--Football STH
UPDATE a
SET [Football_Full__c] = ISNULL(c.FB_STH,0)
FROM [dbo].[Contact_Custom] a WITH (NOLOCK)
LEFT JOIN (SELECT DISTINCT [b].[SSB_CRMSYSTEM_Contact_ID], 1 AS FB_STH
			FROM [AuburnUniv].[dbo].[vwTIReportBase] rb
			INNER JOIN [AuburnUniv].dbo.[vwDimCustomer_ModAcctId] b ON  b.SourceSystem = 'Paciolan' 
																			AND rb.CUSTOMER = b.SSID
			WHERE rb.SEASON IN (select MAX(rb.SEASON) FROM [AuburnUniv].[dbo].[vwTIReportBase] rb
                                    where  rb.SEASON LIKE 'F1%')
			AND rb.ITEM IN ('FS', 'FAC', 'EN2', '6G') 
			AND rb.I_PT NOT IN ('APK', 'BRV', 'BRVC', 'CPK', 'ERV', 'ERVC', 'PK', 'SRV', 'SRVC')
			) c
ON c.[SSB_CRMSYSTEM_Contact_ID]=a.[SSB_CRMSYSTEM_Contact_ID__c]

--Football Rookie
UPDATE a
SET [Football_Rookie__c] = ISNULL(c.FB_STH,0)
FROM [dbo].[Contact_Custom] a WITH (NOLOCK)
LEFT JOIN (SELECT DISTINCT [b].[SSB_CRMSYSTEM_Contact_ID], 1 AS FB_STH
			FROM [AuburnUniv].[dbo].[vwTIReportBase] rb
			INNER JOIN [AuburnUniv].dbo.[vwDimCustomer_ModAcctId] b ON  b.SourceSystem = 'Paciolan' 
																			AND rb.CUSTOMER = b.SSID
			WHERE rb.SEASON IN (select MAX(rb.SEASON) FROM [AuburnUniv].[dbo].[vwTIReportBase] rb
                                    where  rb.SEASON LIKE 'F1%')
			AND rb.ITEM IN ('FS', 'FAC', 'EN2', '6G') 
			AND rb.I_PT NOT IN ('APK', 'BRV', 'BRVC', 'CPK', 'ERV', 'ERVC', 'PK', 'SRV', 'SRVC')
			AND rb.CUSTOMER NOT IN (SELECT rb.CUSTOMER 
									FROM [AuburnUniv].[dbo].[vwTIReportBase] rb
									INNER JOIN [AuburnUniv].dbo.[vwDimCustomer_ModAcctId] b ON  b.SourceSystem = 'Paciolan' 
																									AND rb.CUSTOMER = b.SSID
									WHERE rb.SEASON IN (select rb.SEASON FROM [AuburnUniv].[dbo].[vwTIReportBase] rb
															where  rb.SEASON LIKE 'F1%'
															AND CAST(RIGHT(rb.SEASON,2) AS INT) = RIGHT(DATEPART(YEAR,GETDATE()),2)-1
															AND rb.ITEM IN ('FS', 'FAC', 'EN2', '6G') 
															AND rb.I_PT NOT IN ('APK', 'BRV', 'BRVC', 'CPK', 'ERV', 'ERVC', 'PK', 'SRV', 'SRVC')
														)
									) 
			) c
ON c.[SSB_CRMSYSTEM_Contact_ID]=a.[SSB_CRMSYSTEM_Contact_ID__c]

--Football Partial
UPDATE a
SET [Football_Partial__c] = ISNULL(c.FB_PART, 0)
FROM [dbo].[Contact_Custom] a WITH (NOLOCK)
LEFT JOIN (SELECT DISTINCT [b].[SSB_CRMSYSTEM_Contact_ID], 1 AS FB_PART
			FROM [AuburnUniv].[dbo].[vwTIReportBase] rb (NOLOCK)
			INNER JOIN [AuburnUniv].dbo.TK_ITEM i (NOLOCK) ON rb.SEASON COLLATE SQL_Latin1_General_CP1_CS_AS = i.SEASON COLLATE SQL_Latin1_General_CP1_CS_AS 
															AND rb.ITEM COLLATE SQL_Latin1_General_CP1_CS_AS = i.ITEM COLLATE SQL_Latin1_General_CP1_CS_AS
			INNER JOIN [AuburnUniv].dbo.[vwDimCustomer_ModAcctId] b ON  b.SourceSystem = 'Paciolan' 
																			AND rb.CUSTOMER = b.SSID
			WHERE rb.SEASON IN (select MAX(rb.SEASON) FROM [AuburnUniv].[dbo].[vwTIReportBase] rb
                                    where  rb.SEASON LIKE 'F1%')
			AND i.NAME LIKE '%Pack%'
			) c
ON c.[SSB_CRMSYSTEM_Contact_ID]=a.[SSB_CRMSYSTEM_Contact_ID__c]

--MBB Season
UPDATE a
SET [Men_s_Basketball_Full__c] = ISNULL(c.MB_STH,0)
FROM [dbo].[Contact_Custom] a WITH (NOLOCK)
LEFT JOIN (SELECT DISTINCT [b].[SSB_CRMSYSTEM_Contact_ID], 1 AS MB_STH
			FROM [AuburnUniv].[dbo].[vwTIReportBase] rb (NOLOCK)
			INNER JOIN [AuburnUniv].dbo.[vwDimCustomer_ModAcctId] b ON  b.SourceSystem = 'Paciolan' 
																			AND rb.CUSTOMER = b.SSID
			WHERE rb.SEASON IN (select MAX(rb.SEASON) FROM [AuburnUniv].[dbo].[vwTIReportBase] rb
                                    where  rb.SEASON LIKE 'B1%')
			AND rb.ITEM = 'BS'
			) c
ON c.[SSB_CRMSYSTEM_Contact_ID]=a.[SSB_CRMSYSTEM_Contact_ID__c]

--MBB Rookie
UPDATE a
SET [Men_s_Basketball_Rookie__c] = ISNULL(c.MB_STH,0)
FROM [dbo].[Contact_Custom] a WITH (NOLOCK)
LEFT JOIN (SELECT DISTINCT [b].[SSB_CRMSYSTEM_Contact_ID], 1 AS MB_STH
			FROM [AuburnUniv].[dbo].[vwTIReportBase] rb (NOLOCK)
			INNER JOIN [AuburnUniv].dbo.[vwDimCustomer_ModAcctId] b ON  b.SourceSystem = 'Paciolan' 
																			AND rb.CUSTOMER = b.SSID
			WHERE rb.SEASON IN (SELECT MAX(rb.SEASON) FROM [AuburnUniv].[dbo].[vwTIReportBase] rb
                                WHERE  rb.SEASON LIKE 'B1%')
								AND rb.ITEM = 'BS'
								AND rb.CUSTOMER NOT IN (SELECT rb.CUSTOMER FROM [AuburnUniv].[dbo].[vwTIReportBase] rb
														INNER JOIN [AuburnUniv].dbo.[vwDimCustomer_ModAcctId] b ON  b.SourceSystem = 'Paciolan' 
																									AND rb.CUSTOMER = b.SSID
														WHERE rb.SEASON IN (select rb.SEASON FROM [AuburnUniv].[dbo].[vwTIReportBase] rb
																				WHERE  rb.SEASON LIKE 'B1%'
																				AND CAST(RIGHT(rb.SEASON,2) AS INT) = RIGHT(DATEPART(YEAR,GETDATE()),2)-1
																				AND rb.ITEM = 'BS')
															)
			) c
ON c.[SSB_CRMSYSTEM_Contact_ID]=a.[SSB_CRMSYSTEM_Contact_ID__c]

--MBB Partial
UPDATE a
SET [Men_s_Basketball_Partial__c] = ISNULL(c.MB_PART,0)
FROM [dbo].[Contact_Custom] a WITH (NOLOCK)
LEFT JOIN (SELECT DISTINCT [b].[SSB_CRMSYSTEM_Contact_ID], 1 AS MB_PART
			FROM [AuburnUniv].[dbo].[vwTIReportBase] rb (NOLOCK)
			INNER JOIN [AuburnUniv].dbo.TK_ITEM i (NOLOCK) ON rb.SEASON COLLATE SQL_Latin1_General_CP1_CS_AS = i.SEASON COLLATE SQL_Latin1_General_CP1_CS_AS 
															AND rb.ITEM COLLATE SQL_Latin1_General_CP1_CS_AS = i.ITEM COLLATE SQL_Latin1_General_CP1_CS_AS
			INNER JOIN [AuburnUniv].dbo.[vwDimCustomer_ModAcctId] b ON  b.SourceSystem = 'Paciolan' 
																			AND rb.CUSTOMER = b.SSID
			WHERE rb.SEASON IN (select MAX(rb.SEASON) FROM [AuburnUniv].[dbo].[vwTIReportBase] rb
                                    where  rb.SEASON LIKE 'B1%')
			AND i.NAME LIKE '%Pack%'
			) c
ON c.[SSB_CRMSYSTEM_Contact_ID]=a.[SSB_CRMSYSTEM_Contact_ID__c]


--Email Last Engagement Date

UPDATE a
SET  [SSB_CRMSYSTEM_Last_Adobe_Engagement_Date__c] = x.Engagement_Date
FROM [dbo].[Contact_Custom] a 
       INNER JOIN (SELECT [b].[SSB_CRMSYSTEM_Contact_ID],MAX(LogDate) AS Engagement_Date FROM [AuburnUniv].[ods].[Adobe_TrackingLog] a (NOLOCK)
					INNER JOIN dbo.[vwDimCustomer_ModAcctId] b ON [a].AccountFK = b.SSID AND b.SourceSystem = 'Adobe'
					GROUP BY [b].[SSB_CRMSYSTEM_Contact_ID]) x
       ON a.SSB_CRMSYSTEM_CONTACT_ID__c = x.SSB_CRMSYSTEM_CONTACT_ID


--Priority Points
UPDATE a
SET [Priority_Points_Football__c] = pp.FootballPriority
	, [Priority_Points_Mens_Basketball__c] = pp.BasketballPriority
	, [Priority_Points_Baseball__c] = pp.BaseballPriority
FROM [dbo].[Contact_Custom] a
INNER JOIN (SELECT [b].[SSB_CRMSYSTEM_Contact_ID]
					,pp.FootballPriority
					,pp.BasketballPriority
					,pp.BaseballPriority FROM  [AuburnUniv].[dbo].[TUFPriority_PriorityTotals] pp
			INNER JOIN dbo.[vwDimCustomer_ModAcctId] b ON [pp].DONOR = b.SSID AND b.SourceSystem = 'Paciolan' AND SSB_CRMSYSTEM_PRIMARY_FLAG = '1'
			 )pp
ON  pp.[SSB_CRMSYSTEM_Contact_ID] = a.[SSB_CRMSYSTEM_Contact_ID__c] 

UPDATE dbo.Contact_Custom
SET SSB_CRMSYSTEM_DimCustomerID__c =  LEFT(SSB_CRMSYSTEM_DimCustomerID__c,CHARINDEX(',',SSB_CRMSYSTEM_DimCustomerID__c,245)-1)
FROM dbo.Contact_Custom
WHERE LEN(SSB_CRMSYSTEM_DimCustomerID__c) > 255



EXEC  [dbo].[sp_CRMLoad_Contact_ProcessLoad_Criteria]

GO
