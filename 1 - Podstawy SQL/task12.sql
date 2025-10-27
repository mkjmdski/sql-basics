WITH
GetDuplicatedProducts AS (
	SELECT ProductName 
	FROM Products
	GROUP BY ProductName
	HAVING COUNT(*) > 1
)
SELECT 
	CASE 
		WHEN COUNT(*) = 0 THEN 'No'
		ELSE 'Yes'
	END AS DuplicateProductsFlag
FROM GetDuplicatedProducts