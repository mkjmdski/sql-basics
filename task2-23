SELECT 
C.CategoryID, C.CategoryName, SUM(P.UnitPrice * P.UnitsInStock) AS SumValueProductsInStock
FROM
	Products P
	JOIN Categories C
		ON C.CategoryID = P.CategoryID
GROUP BY C.CategoryID, C.CategoryName
HAVING SUM(P.UnitPrice * P.UnitsInStock) > 10000
