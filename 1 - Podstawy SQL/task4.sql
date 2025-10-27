SELECT P1.ProductName, P1.UnitPrice
FROM Products P1
WHERE P1.UnitPrice > ALL(
	SELECT AVG(P2.UnitPrice)
	FROM Products P2
	WHERE P1.CategoryID != P2.CategoryID
	GROUP BY P2.CategoryID
)
ORDER BY P1.UnitPrice DESC;


WITH CategoryAvgPrices AS (
	SELECT CategoryID, AVG(UnitPrice) AS AvgUnitPrice
	FROM Products
	GROUP BY CategoryID
)
SELECT P.ProductName, P.UnitPrice
FROM Products P
WHERE P.UnitPrice > ALL (
	SELECT A.AvgUnitPrice
	FROM CategoryAvgPrices A
	WHERE A.CategoryID != P.CategoryID
)
ORDER BY P.UnitPrice DESC;
