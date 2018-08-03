SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO








CREATE VIEW [MERGEPROCESS_New].[vwMergeAccountRanks]

AS

SELECT a.SSBID
	, c.ID
	--Add in custom ranking here
	,ROW_NUMBER() OVER(PARTITION BY SSBID ORDER BY CASE WHEN d.name LIKE '%ETL%' OR d.name LIKE '%SSB%' THEN 0  --UpdateME
														WHEN d.IsActive = 0 THEN 1 
														WHEN Auburn_Sports_Participant__c = 1 THEN 99
														ELSE 98 END DESC, c.LastActivityDate DESC, c.createddate ASC) xRank
FROM MERGEPROCESS_New.DetectedMerges a WITH (NOLOCK)
JOIN mergeprocess_new.tmp_dimcust b WITH (NOLOCK)
	ON a.SSBID = b.SSB_CRMSYSTEM_CONTACT_ID
	AND a.MergeType = 'Account'
JOIN mergeprocess_new.tmp_pcaccount c WITH (NOLOCK)
	ON b.SSID = ID
JOIN [prodcopy].[user] d
	ON c.OwnerId = d.Id
WHERE MergeComplete = 0;







GO
