SELECT 
	p.ProductName, 
	p.UnitPrice,
	c.CategoryName, 
	s.CompanyName AS SupplierName
FROM Products p 
	JOIN Categories c
		ON p.CategoryID = c.CategoryID
	JOIN Suppliers s
		ON s.SupplierID = p.SupplierID
ORDER BY p.UnitPrice DESC;