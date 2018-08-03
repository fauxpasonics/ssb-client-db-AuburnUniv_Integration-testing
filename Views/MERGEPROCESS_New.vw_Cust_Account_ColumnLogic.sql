SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





CREATE VIEW [MERGEPROCESS_New].[vw_Cust_Account_ColumnLogic]
AS
SELECT  ID,
		Losing_ID AS Losing_ID ,					
        CAST(SUBSTRING(PersonTitle, 2, 82) AS nvarchar(80)) PersonTitle,
		ISNULL(CAST(SUBSTRING(AClub_Member_Flag__c, 2, 1) AS BIT),0) AClub_Member_Flag__c,
		ISNULL(CAST(SUBSTRING(Broker__c, 2, 1) AS BIT),0) Broker__c,
		CAST(SUBSTRING(Alumni_Membership__c, 2, 52) AS NVARCHAR(50)) Alumni_Membership__c,
		CAST(SUBSTRING(Auburn_Sport__c, 2, 52) AS NVARCHAR(50)) Auburn_Sport__c,
		CAST(SUBSTRING(Maiden_Name__c, 2, 52) AS NVARCHAR(255)) Maiden_Name__c,
		CAST(SUBSTRING(Spouse_Name__c, 2, 52) AS NVARCHAR(255)) Spouse_Name__c,
		CAST(SUBSTRING(Degree__c, 2, 52) AS NVARCHAR(255)) Degree__c, 
		CAST(SUBSTRING(Degree_Type__c, 2, 52) AS NVARCHAR(255)) Degree_Type__c,
		CAST(SUBSTRING(Job_Title__c, 2, 52) AS NVARCHAR(255)) Job_Title__c


FROM    ( SELECT    Winning_ID AS ID ,
					Losing_ID AS Losing_ID ,					
                    MAX(CASE WHEN dta.xtype = 'Winning'
                                  AND PersonTitle IS NOT NULL and Persontitle != ''
                             THEN '2' + CAST(PersonTitle AS VARCHAR(80))
                             WHEN dta.xtype = 'Losing'
                                  AND PersonTitle IS NOT NULL and Persontitle != ''
                             THEN '1' + CAST(PersonTitle AS VARCHAR(80))
                        END) PersonTitle,

					 MAX(CASE WHEN dta.xtype = 'Winning'
                                  AND AClub_Member_Flag__c IS NOT NULL AND	AClub_Member_Flag__c != ''
                             THEN '2' + CAST(AClub_Member_Flag__c AS NVARCHAR(50))
                             WHEN dta.xtype = 'Losing'
                                  AND AClub_Member_Flag__c IS NOT NULL AND AClub_Member_Flag__c != ''
                             THEN '1' + CAST(AClub_Member_Flag__c AS NVARCHAR(50))
                        END) AClub_Member_Flag__c,

					 MAX(CASE WHEN dta.xtype = 'Winning'
                                  AND Broker__c IS NOT NULL AND	Broker__c != ''
                             THEN '2' + CAST(Broker__c AS NVARCHAR(50))
                             WHEN dta.xtype = 'Losing'
                                  AND Broker__c IS NOT NULL AND Broker__c != ''
                             THEN '1' + CAST(Broker__c AS NVARCHAR(50))
                        END) Broker__c,

					MAX(CASE WHEN dta.xtype = 'Winning'
                                  AND Alumni_Membership__c IS NOT NULL AND Alumni_Membership__c != ''
                             THEN '2' + CAST(Alumni_Membership__c AS NVARCHAR(50))
                             WHEN dta.xtype = 'Losing'
                                  AND Alumni_Membership__c IS NOT NULL AND Alumni_Membership__c != ''
                             THEN '1' + CAST(Alumni_Membership__c AS NVARCHAR(50))
                        END) Alumni_Membership__c,

					MAX(CASE WHEN dta.xtype = 'Winning'
                                  AND Auburn_Sport__c IS NOT NULL AND Auburn_Sport__c != ''
                             THEN '2' + CAST(Auburn_Sport__c AS NVARCHAR(50))
                             WHEN dta.xtype = 'Losing'
                                  AND Auburn_Sport__c IS NOT NULL AND Auburn_Sport__c != ''
                             THEN '1' + CAST(Auburn_Sport__c AS NVARCHAR(50))
                        END) Auburn_Sport__c,

					MAX(CASE WHEN dta.xtype = 'Winning'
                                  AND Maiden_Name__c IS NOT NULL AND Maiden_Name__c != ''
                             THEN '2' + CAST(Maiden_Name__c AS NVARCHAR(255))
                             WHEN dta.xtype = 'Losing'
                                  AND Maiden_Name__c IS NOT NULL AND Auburn_Sport__c != ''
                             THEN '1' + CAST(Maiden_Name__c AS NVARCHAR(255))
                        END) Maiden_Name__c,

					MAX(CASE WHEN dta.xtype = 'Winning'
                                  AND Spouse_Name__c IS NOT NULL AND Spouse_Name__c != ''
                             THEN '2' + CAST(Spouse_Name__c AS NVARCHAR(255))
                             WHEN dta.xtype = 'Losing'
                                  AND Spouse_Name__c IS NOT NULL AND Spouse_Name__c != ''
                             THEN '1' + CAST(Spouse_Name__c AS NVARCHAR(255))
                        END) Spouse_Name__c,

					MAX(CASE WHEN dta.xtype = 'Winning'
                                  AND Degree__c IS NOT NULL AND Degree__c != ''
                             THEN '2' + CAST(Degree__c AS NVARCHAR(255))
                             WHEN dta.xtype = 'Losing'
                                  AND Degree__c IS NOT NULL AND Degree__c != ''
                             THEN '1' + CAST(Degree__c AS NVARCHAR(255))
                        END) Degree__c,

					MAX(CASE WHEN dta.xtype = 'Winning'
                                  AND Degree_Type__c IS NOT NULL AND Degree_Type__c != ''
                             THEN '2' + CAST(Degree_Type__c AS NVARCHAR(255))
                             WHEN dta.xtype = 'Losing'
                                  AND Degree_Type__c IS NOT NULL AND Degree_Type__c != ''
                             THEN '1' + CAST(Degree_Type__c AS NVARCHAR(255))
                        END) Degree_Type__c, 

					MAX(CASE WHEN dta.xtype = 'Winning'
                                  AND Job_Title__c IS NOT NULL AND Job_Title__c != ''
                             THEN '2' + CAST(Job_Title__c AS NVARCHAR(255))
                             WHEN dta.xtype = 'Losing'
                                  AND Job_Title__c IS NOT NULL AND Job_Title__c != ''
                             THEN '1' + CAST(Job_Title__c AS NVARCHAR(255))
                        END) Job_Title__c				                    
FROM      ( SELECT    *
            FROM      ( SELECT    'Winning' xtype ,
                                a.Winning_ID ,
								a.Losing_ID ,					
                                b.*
                        FROM      [MERGEPROCESS_New].[Queue] a
                                JOIN Prodcopy.vw_Account b ON a.Winning_ID = b.ID
                        UNION ALL
                        SELECT    'Losing' xtype ,
                                a.Winning_ID ,
								a.Losing_ID ,					
                                b.*
                        FROM      [MERGEPROCESS_New].[Queue] a
                                JOIN Prodcopy.vw_Account b ON a.Losing_ID = b.ID
                    ) x
        ) dta

GROUP BY  Winning_ID ,
		Losing_ID					
        ) aa

;




GO
