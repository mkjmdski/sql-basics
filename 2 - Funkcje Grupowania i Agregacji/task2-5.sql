/*
Korzystając z tabel Orders, Customers oraz Order Details przedstaw średnią, minimalną oraz
maksymalną wartość zamówienia (zaokrąglonego do dwóch miejsc po przecinku, bez uwzględnienia
zniżki) dla każdego z klientów (Customers.CustomerID). Wyniki posortuj zgodnie ze średnią wartością
zamówienia – malejąco. Pamiętaj, aby średnią, minimalną oraz maksymalną wartość zamówienia
wyliczyć bazując na jego wartości, czyli sumie iloczynów cen jednostkowych oraz wielkości zamówienia.
*/


SELECT 
	C.CustomerID,
	ROUND(AVG(OD.Quantity * OD.UnitPrice), 2) AS AveragePrice,
	MIN(OD.Quantity * OD.UnitPrice) AS MinPrice,
	MAX(OD.Quantity * OD.UnitPrice) AS MaxPrice
FROM Orders O
	JOIN [Order Details] OD
		ON O.OrderID = OD.OrderID
	JOIN Customers C
		ON C.CustomerID = O.CustomerID
GROUP BY
	C.CustomerID
ORDER BY
	AveragePrice DESC
