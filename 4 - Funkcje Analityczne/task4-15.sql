IF OBJECT_ID('dbo.MyCategories') IS NOT NULL DROP TABLE dbo.MyCategories;
SELECT * INTO dbo.MyCategories FROM dbo.Categories
UNION ALL
SELECT * FROM dbo.Categories
UNION ALL
SELECT * FROM dbo.Categories;
-- remove duplicates
WITH Duplicates AS (
    SELECT 
        *,
        ROW_NUMBER() OVER(PARTITION BY CategoryID ORDER BY CategoryID) AS RN
    FROM dbo.MyCategories
)
DELETE FROM Duplicates
WHERE RN > 1;
SELECT * FROM dbo.MyCategories
