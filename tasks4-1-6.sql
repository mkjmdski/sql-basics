SELECT
	ROUND(AVG(P.UnitPrice), 2) AS Avg
FROM Products p

SELECT DISTINCT
	C.CategoryName,
	ROUND(AVG(P.UnitPrice) OVER (PARTITION BY P.CategoryID), 2) as AvgPrice
FROM Products P
	JOIN Categories C
		ON C.CategoryID = P.CategoryID

SELECT
	ProductName,
	CategoryName,
	ROUND(AVG(UnitPrice) OVER (), 2) as AvgPrice
FROM (
	SELECT 
		P.ProductName, 
		C.CategoryName,
		P.UnitPrice,
		P.CategoryID
	FROM Products P
		JOIN Categories C
			ON C.CategoryID = P.CategoryID
	WHERE C.CategoryName != 'Beverages'
) NotBeverages
ORDER BY ProductName

SELECT 
	P.ProductName, 
	C.CategoryName,
	ROUND(AVG(UnitPrice) OVER (), 2) as AvgPrice,
	ROUND(MIN(UnitPrice) OVER(), 2) as MinPrice,
	ROUND(MAX(UnitPrice) OVER(), 2) as MaxPrice
FROM Products P
	JOIN Categories C
		ON C.CategoryID = P.CategoryID
ORDER BY ProductName



SELECT 
	P.ProductName, 
	C.CategoryName,

	ROUND(MIN(UnitPrice) OVER(), 2) as MinPrice,
--	ROUND(MIN(UnitPrice) OVER (PARTITION BY P.CategoryID), 2) as MinCategoryPrice,

	ROUND(MAX(UnitPrice) OVER(), 2) as MaxPrice,
--	ROUND(MAX(UnitPrice) OVER (PARTITION BY P.CategoryID), 2) as MaxCategoryPrice,

	ROUND(AVG(UnitPrice) OVER (), 2) as AvgPrice,
	ROUND(AVG(UnitPrice) OVER (PARTITION BY P.CategoryID), 2) as AvgCategoryPrice,
	ROUND(AVG(UnitPrice) OVER (PARTITION BY P.SupplierID), 2) as AvgSupplierPrice
FROM Products P
	JOIN Categories C
		ON C.CategoryID = P.CategoryID
ORDER BY ProductName



SELECT 
	P.ProductName, 
	C.CategoryName,

	ROUND(MIN(UnitPrice) OVER(), 2) as MinPrice,
--	ROUND(MIN(UnitPrice) OVER (PARTITION BY P.CategoryID), 2) as MinCategoryPrice,

	ROUND(MAX(UnitPrice) OVER(), 2) as MaxPrice,
--	ROUND(MAX(UnitPrice) OVER (PARTITION BY P.CategoryID), 2) as MaxCategoryPrice,

	ROUND(AVG(UnitPrice) OVER (), 2) as AvgPrice,
	ROUND(AVG(UnitPrice) OVER (PARTITION BY P.CategoryID), 2) as AvgCategoryPrice,
	ROUND(AVG(UnitPrice) OVER (PARTITION BY P.SupplierID), 2) as AvgSupplierPrice,
	COUNT(1) OVER (PARTITION BY P.CategoryID) as ProductsInCategory
FROM Products P
	JOIN Categories C
		ON C.CategoryID = P.CategoryID
ORDER BY ProductName
