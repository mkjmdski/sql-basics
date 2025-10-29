/*
Korzystając z tabel Orders, Customers oraz Order Details przedstaw średnią, minimalną oraz
maksymalną wartość zamówienia (zaokrąglonego do dwóch miejsc po przecinku, bez uwzględnienia
zniżki) dla każdego z klientów (Customers.CustomerID). Wyniki posortuj zgodnie ze średnią wartością
zamówienia – malejąco. Pamiętaj, aby średnią, minimalną oraz maksymalną wartość zamówienia
wyliczyć bazując na jego wartości, czyli sumie iloczynów cen jednostkowych oraz wielkości zamówienia.
*/


WITH OrderTotals AS (
  SELECT
    O.OrderID,
    O.CustomerID,
    SUM(OD.Quantity * OD.UnitPrice) AS OrderTotal
  FROM Orders O
  JOIN [Order Details] OD 
    ON O.OrderID = OD.OrderID
  GROUP BY O.OrderID, O.CustomerID
)
 
SELECT
  C.CustomerID,
  ROUND(AVG(OT.OrderTotal), 2) AS AveragePrice,
  ROUND(MIN(OT.OrderTotal), 2) AS MinPrice,
  ROUND(MAX(OT.OrderTotal), 2) AS MaxPrice
FROM OrderTotals OT
JOIN Customers C 
  ON C.CustomerID = OT.CustomerID
GROUP BY C.CustomerID
ORDER BY AveragePrice DESC;
