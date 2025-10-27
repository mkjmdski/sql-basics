SELECT DISTINCT
	P.ProductID, 
	P.ProductName, 
	S.Country AS SupplierCountry, 
	S.City AS SupplierCity, 
	O.ShipCountry, 
	O.ShipCity,
	CASE
		WHEN S.City = O.ShipCity THEN 'Yes'
		ELSE 'No'
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
