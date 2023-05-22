-- RECALL dataset using National Highway Traffic Safety Administration data
-- Last Updated: 2023.05.22
-- https://catalog.data.gov/dataset/recalls-data



SELECT *
FROM PortfolioProject.dbo.Recalls_Data




-- Number of Recalls per Year
SELECT 
	YEAR(Report_Received_Date) AS year, 
	COUNT(*) AS number_of_recalls
FROM PortfolioProject.dbo.Recalls_Data
GROUP BY YEAR(Report_Received_Date)
ORDER BY year





-- Number of recalls by recall-type
SELECT
	Recall_Type,
	COUNT(*) AS num_recalls
FROM PortfolioProject.dbo.Recalls_data
GROUP BY Recall_type



  -- ALL TIME - Recalls grouped by Component
SELECT 
	Component, 
	COUNT(*) as num_recalls
FROM PortfolioProject.dbo.Recalls_Data
GROUP BY Component
ORDER BY num_recalls DESC





-- Recalls by Manufactuerer and Component
SELECT
	Manufacturer,
	Component,
	COUNT(*) AS num_recalls,
	SUM(Potentially_Affected) AS potential_affected_parts
FROM PortfolioProject.dbo.Recalls_Data
WHERE Potentially_Affected IS NOT NULL
GROUP BY Manufacturer, Component




-- Recalls by Manufacturer and potential affected parts
SELECT
	Manufacturer,
	COUNT(*) AS num_recalls,
	SUM(Potentially_Affected) AS potential_affected_parts
FROM PortfolioProject.dbo.Recalls_Data
WHERE Potentially_Affected IS NOT NULL
GROUP BY Manufacturer
ORDER BY 3 DESC




-- Recalls by Components per Year
SELECT 
	YEAR(Report_Received_Date) AS year, 
	Component,
	COUNT(*) AS number_of_recalls,
	SUM(Potentially_Affected) AS total_potentially_affected
FROM PortfolioProject.dbo.Recalls_Data
WHERE Potentially_Affected IS NOT NULL
GROUP BY YEAR(Report_Received_Date), Component
ORDER BY 2,1





-- Compare each recall to the Manufacturer's total potential affect parts and number of recalls
SELECT 
	Report_Received_Date,
	Component,
	Manufacturer,
	SUM(Potentially_Affected) AS potential_affected_parts,
	SUM(Potentially_Affected) OVER (PARTITION BY Manufacturer) AS total_potential_affected_parts,
	COUNT(*) OVER (PARTITION BY Manufacturer) AS total_manu_recalls
FROM PortfolioProject.dbo.Recalls_Data
GROUP BY Report_Received_Date, Component, Manufacturer, Potentially_Affected
ORDER BY Manufacturer, Component




-- Comparing each recall to all recalls by each manufacturer
WITH recalls_by_manufactuerer (Report_Received_Date, Recall_Type, Component, Manufacturer, potential_affected_parts, total_potential_affected_parts, total_manu_recalls)
AS (
SELECT 
	Report_Received_Date,
	Recall_Type,
	Component,
	Manufacturer,
	SUM(Potentially_Affected) AS potential_affected_parts,
	SUM(Potentially_Affected) OVER (PARTITION BY Manufacturer) AS total_potential_affected_parts,
	COUNT(*) OVER (PARTITION BY Manufacturer) AS total_manu_recalls
FROM PortfolioProject.dbo.Recalls_Data
WHERE Potentially_Affected IS NOT NULL
GROUP BY Report_Received_Date, Recall_Type, Component, Manufacturer, Potentially_Affected
--ORDER BY Manufacturer, Component
)
SELECT 
	*, 
	((CAST(potential_affected_parts AS FLOAT) / CAST(total_potential_affected_parts AS FLOAT)) * 100) AS perc_of_total_manu_recalls 
FROM recalls_by_manufactuerer





-- Manufacturer break-down by Components
SELECT
	Manufacturer,
	Component,
	SUM(Potentially_Affected) AS potentially_affected_parts,
	COUNT(*) AS manu_component_num_recalls
FROM PortfolioProject.dbo.Recalls_Data
WHERE Potentially_Affected IS NOT NULL
GROUP BY Component, Manufacturer
--ORDER BY 1,3 DESC
ORDER BY 4 DESC


