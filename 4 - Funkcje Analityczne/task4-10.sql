SELECT * 
FROM (
	SELECT
		P.ProductID,
		P.ProductName,
		C.CategoryName,
		P.UnitPrice,
		DENSE_RANK() OVER (
			PARTITION BY P.CategoryID 
			ORDER BY P.UnitPrice
		) as ProductRank
	FROM Products P
	JOIN Categories C ON P.CategoryID = C.CategoryID
) PR
WHERE PR.ProductRank <= 5
ORDER BY PR.CategoryName ASC, PR.ProductRank ASC
