WITH CategoryAvgPrices AS (
	SELECT CategoryID, AVG(UnitPrice) AS AvgUnitPrice
	FROM Products
	GROUP BY CategoryID
),
ProductsWithPriceHigherThanAvgInOtherCategories AS (
	SELECT P.ProductName, P.UnitPrice, P.ProductID
	FROM Products P
	WHERE P.UnitPrice > ALL (
		SELECT A.AvgUnitPrice
		FROM CategoryAvgPrices A
		WHERE A.CategoryID != P.CategoryID
	)
)

SELECT P.ProductName, MAX(O.Quantity) AS MaxQuantityPerOrder
FROM ProductsWithPriceHigherThanAvgInOtherCategories P 
	JOIN [Order Details] O
		ON P.ProductID = O.ProductID
GROUP BY P.ProductName;