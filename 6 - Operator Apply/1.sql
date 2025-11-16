SELECT P.ProductID, P.ProductName, S.CompanyName
FROM Products P
CROSS APPLY (
	SELECT CompanyName
	FROM Suppliers Sup
	WHERE Sup.SupplierID = P.SupplierID
) AS S
ORDER BY ProductID
/*
(
	SELECT P.ProductID, P.ProductName, S.CompanyName
	FROM Products P
	CROSS APPLY (
		SELECT CompanyName
		FROM Suppliers Sup
		WHERE Sup.SupplierID = P.SupplierID
	) AS S
)
EXCEPT
(
	SELECT P.ProductID, P.ProductName, S.CompanyName
	FROM Products P JOIN Suppliers S
	ON P.SupplierID = S.SupplierID
)
*/
