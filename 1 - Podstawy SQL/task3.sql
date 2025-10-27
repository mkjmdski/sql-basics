SET STATISTICS IO ON;
SET STATISTICS TIME ON;

WITH 
MaxPricesPerCategory (CategoryID, MaxUnitPrice) AS (
	SELECT CategoryID, MAX(UnitPrice) as MaxUnitPrice
	FROM Products
	GROUP BY CategoryID
)
SELECT P.ProductName, P.UnitPrice
FROM Products P
JOIN MaxPricesPerCategory M
	ON  M.CategoryID = P.CategoryID
	AND M.MaxUnitPrice = P.UnitPrice
ORDER BY ProductName ASC;

/* Is the first one faster? */

SELECT ProductName, UnitPrice
FROM Products P1
WHERE P1.UnitPrice = 
    (SELECT MAX(P2.UnitPrice)
     FROM Products P2
     WHERE P1.CategoryID = P2.CategoryID)
ORDER BY ProductName ASC;