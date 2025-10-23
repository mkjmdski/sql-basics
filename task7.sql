WITH GetCategorySumInOrders AS (
	SELECT P.CategoryID, SUM(O.UnitPrice * O.Quantity) AS OrderValue
	FROM [Products] P
		JOIN [Order Details] O
			ON P.ProductID = O.ProductID
	GROUP BY P.CategoryID
	HAVING SUM(O.UnitPrice * O.Quantity) > 200000
)
SELECT G.CategoryID, G.OrderValue, C.CategoryName
FROM GetCategorySumInOrders G
	JOIN Categories C
		ON C.CategoryID = G.CategoryID;
