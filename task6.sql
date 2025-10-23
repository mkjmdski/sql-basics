SELECT P.CategoryID, SUM(O.UnitPrice * O.Quantity) AS 'Value'
FROM [Products] P
	JOIN [Order Details] O
	ON P.ProductID = O.ProductID
GROUP BY P.CategoryID
HAVING SUM(O.UnitPrice * O.Quantity) > 200000;