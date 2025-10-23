SELECT P.ProductName, COUNT(*) AS NumberOfOrd
FROM [Products] P
	JOIN [Order Details] O
		ON P.ProductID = O.ProductID
GROUP BY P.ProductID, P.ProductName