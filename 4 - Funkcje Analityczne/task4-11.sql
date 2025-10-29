SELECT * FROM (
	SELECT DISTINCT 
		P.ProductID,
		P.ProductName,
		AVG(OD.Quantity * OD.UnitPrice) OVER (
			PARTITION BY P.CategoryID
		) AS AverageCategoryPrice,
		MAX(OD.Quantity * OD.UnitPrice) OVER (
			PARTITION BY P.ProductID
		) AS MaxProductPrice
	FROM Products P
	JOIN [Order Details] OD ON OD.ProductID = P.ProductID
) PC
WHERE  PC.MaxProductPrice < PC.AverageCategoryPrice
ORDER BY PC.ProductID ASC
