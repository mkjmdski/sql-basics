SELECT DISTINCT
	P.ProductID, 
	P.ProductName, 
	S.Country AS SupplierCountry, 
	S.City AS SupplierCity, 
	S.Region AS SupplierRegion,
	O.ShipCountry, 
	O.ShipCity,
	O.ShipRegion,
	CASE
		WHEN S.City = O.ShipCity AND ISNULL(S.Region, 'null') = ISNULL(O.ShipRegion, 'null') THEN 'Y'
		WHEN S.City = O.ShipCity THEN 'N(Region does not match)'
		ELSE 'N'
	END AS FullMatch
FROM [Products] P
	JOIN [Order Details] OD
		ON OD.ProductID = P.ProductID
	JOIN [Orders] O
		ON O.OrderID = OD.OrderID
	JOIN [Suppliers] S 
		ON S.SupplierID = P.SupplierID
WHERE O.ShipCountry = S.Country
ORDER BY FullMatch DESC, ProductName ASC;
