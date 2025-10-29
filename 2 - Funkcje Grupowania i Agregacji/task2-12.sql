SELECT *
FROM (
	SELECT 
		O.ShipCountry,
		S.CompanyName,
		COUNT(O.OrderID) as OrderCount
	FROM Orders O
		JOIN Shippers S
			ON S.ShipperID = O.ShipVia
	GROUP BY O.ShipCountry, S.CompanyName
) AS OrdersByCompany
PIVOT (
	SUM(OrderCount)
	FOR CompanyName IN (
		[Federal Shipping],
		[Speedy Express],
		[United Package]
	)
) AS PivotedOrders
ORDER BY ShipCountry;

SELECT 
  O.ShipCountry,
  SUM(CASE WHEN S.CompanyName = 'Federal Shipping' THEN 1 ELSE 0 END) AS [Federal Shipping],
  SUM(CASE WHEN S.CompanyName = 'Speedy Express' THEN 1 ELSE 0 END) AS [Speedy Express],
  SUM(CASE WHEN S.CompanyName = 'United Package' THEN 1 ELSE 0 END) AS [United Package]
FROM Orders O
JOIN Shippers S ON S.ShipperID = O.ShipVia
GROUP BY O.ShipCountry
ORDER BY O.ShipCountry;