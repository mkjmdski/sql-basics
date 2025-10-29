
SELECT 
*,
RD.MovAvg - LAG(RD.MovAvg) OVER (
	PARTITION BY RD.CategoryID
	ORDER BY RD.UnitPrice ASC, RD.ProductID
) AS MovAvgDiff
FROM 
(
SELECT 
	P.CategoryID,
	P.ProductID,
	C.CategoryName,
	P.UnitPrice,
	SUM(P.UnitPrice) OVER (
		PARTITION BY P.CategoryID
		ORDER BY P.UnitPrice ASC, P.ProductID
		ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
	) AS RunSum,
	ROUND(AVG(P.UnitPrice) OVER (
		PARTITION BY P.CategoryID
		ORDER BY P.UnitPrice ASC, P.ProductID
		ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
	), 2) AS MovAvg,
	MAX(P.UnitPrice) OVER (
		PARTITION BY P.CategoryID
		ORDER BY P.UnitPrice ASC, P.ProductID
		ROWS BETWEEN 2 PRECEDING AND 2 FOLLOWING
	) AS MaxOfFour
FROM Products P
JOIN Categories C ON P.CategoryID = C.CategoryID
) RD
ORDER BY RD.CategoryName, RD.UnitPrice ASC
