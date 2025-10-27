SELECT S.CompanyName, COUNT(DISTINCT OD.OrderID)
FROM Products P
	JOIN Suppliers S
		ON P.SupplierID = S.SupplierID
	JOIN [Order Details] OD
		ON OD.ProductID = P.ProductID
GROUP BY S.SupplierID, S.CompanyName
ORDER BY S.CompanyName ASC
