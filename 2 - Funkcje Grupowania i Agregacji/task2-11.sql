SELECT 
	Cat.CategoryName,
	S.Country AS SupplierCountry,
	Co.Country AS CustomerCountry,
	Co.Region AS CustomerRegion,
	SUM(OD.Quantity * OD.UnitPrice) as OrdersValue,
	CONCAT_WS (
		' & ',
		CASE WHEN GROUPING(Cat.CategoryName) = 0 THEN 'Category' END,
		CASE WHEN GROUPING(S.Country) = 0 THEN 'Country - Supplier' END,
		CASE WHEN GROUPING(Co.Country) + GROUPING(Co.Region) = 0 THEN 'Country & Region - Customer' END
	) AS GroupingLevel
FROM Orders O
	JOIN [Order Details] OD
		ON O.OrderID = OD.OrderID
	JOIN [Customers] Co
		ON O.CustomerID = Co.CustomerID
	JOIN [Products] P
		ON P.ProductID = OD.ProductID
	JOIN [Categories] Cat
		ON Cat.CategoryID = P.CategoryID
	JOIN [Suppliers] S
		ON S.SupplierID = P.SupplierID
GROUP BY GROUPING SETS(
	(Cat.CategoryName), 
	(S.Country), 
	(Co.Country, Co.Region)
)
ORDER BY 
	GroupingLevel ASC,
	OrdersValue DESC
