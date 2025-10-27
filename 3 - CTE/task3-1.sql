WITH
GetAvgPrice AS (
	SELECT AVG(P.UnitPrice) AS AvgPrice, P.CategoryID
	FROM Products P
	GROUP BY P.CategoryID
),
GetProductsWithCostHigherThanAvg AS (
	SELECT P.ProductID, P.ProductName, P.UnitPrice
	FROM Products AS P
	WHERE P.UnitPrice > (
		SELECT AvgPrice 
		FROM GetAvgPrice G 
		WHERE P.CategoryID = G.CategoryID
	)
)
SELECT * FROM GetProductsWithCostHigherThanAvg
ORDER BY UnitPrice


SELECT P1.ProductID, P1.ProductName, P1.UnitPrice
FROM Products AS P1
WHERE P1.UnitPrice > (
	SELECT AvgPrice 
	FROM (
		SELECT AVG(P.UnitPrice) AS AvgPrice, P.CategoryID
		FROM Products P
		GROUP BY P.CategoryID
	) G
	WHERE P1.CategoryID = G.CategoryID
)
ORDER BY P1.UnitPrice
