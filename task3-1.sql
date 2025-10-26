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
