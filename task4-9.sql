DECLARE @pageNum INT = 3
DECLARE @pageSize INT = 15;

WITH
PaginatedProducts AS (
	SELECT 
		P.ProductID,
		P.ProductName,
		C.CategoryName,
		P.UnitPrice,
		ROUND(AVG(P.UnitPrice) OVER (PARTITION BY P.CategoryID), 2) as AvgPriceInCategory,
		ROW_NUMBER() OVER (ORDER BY P.ProductID) as RowNum
	FROM Products P
		JOIN Categories C
			ON P.CategoryID = C.CategoryID
)

SELECT 
	ProductID,
	ProductName,
	CategoryName,
	UnitPrice,
	AvgPriceInCategory,
	@pageNum AS PageNum
FROM PaginatedProducts
WHERE 
	RowNum BETWEEN (@pageNum - 1) * @pageSize + 1 
	AND
	@pageNum * @pageSize
ORDER BY ProductName
