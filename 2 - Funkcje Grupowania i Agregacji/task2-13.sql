--- PIVOT WAY

SELECT *
FROM (
	SELECT 
		O.ShipCountry,
		S.CompanyName,
		OD.Quantity * OD.UnitPrice as OrderValue
	FROM Orders O
		JOIN Shippers S
			ON S.ShipperID = O.ShipVia
		JOIN [Order Details] OD
			ON OD.OrderID = O.OrderID
	GROUP BY O.ShipCountry, S.CompanyName, OD.Quantity, OD.UnitPrice
) AS OrdersByCompany
PIVOT (
	SUM(OrderValue)
	FOR CompanyName IN (
		[Federal Shipping],
		[Speedy Express],
		[United Package]
	)
) AS PivotedOrders
ORDER BY ShipCountry;

--- NON PIVOT WAY

SELECT 
  O.ShipCountry,
  SUM(CASE WHEN S.CompanyName = 'Federal Shipping' THEN OD.Quantity * OD.UnitPrice ELSE 0 END) AS [Federal Shipping],
  SUM(CASE WHEN S.CompanyName = 'Speedy Express' THEN OD.Quantity * OD.UnitPrice ELSE 0 END) AS [Speedy Express],
  SUM(CASE WHEN S.CompanyName = 'United Package' THEN 1 ELSE OD.Quantity * OD.UnitPrice END) AS [United Package]
FROM Orders O
JOIN Shippers S ON S.ShipperID = O.ShipVia
JOIN [Order Details] OD ON OD.OrderID = O.OrderID
GROUP BY O.ShipCountry
ORDER BY O.ShipCountry;