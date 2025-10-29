WITH
AvgPrice AS (
	SELECT 
		P.CategoryID,
		AVG(OD.Quantity * OD.UnitPrice) AS AvgPrice
	FROM Products P
	JOIN [Order Details] OD ON OD.ProductID = P.ProductID
	GROUP BY P.CategoryID
),
MaxPrice AS (
	SELECT 
		P.ProductID,
		MAX(OD.Quantity * OD.UnitPrice) AS MaxPrice
	FROM Products P
	JOIN [Order Details] OD ON OD.ProductID = P.ProductID 
	GROUP BY P.ProductID
)

SELECT 
	P.ProductID,
	P.ProductName,
	AP.AvgPrice,
	MP.MaxPrice
FROM Products P
JOIN MaxPrice MP ON MP.ProductID = P.ProductID
JOIN AvgPrice AP ON AP.CategoryID = P.CategoryID
WHERE MP.MaxPrice < AP.AvgPrice
ORDER BY P.ProductID ASC