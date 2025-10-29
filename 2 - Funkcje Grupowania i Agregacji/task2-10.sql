/*
Korzystając z tabel Orders, Order Details, Customers przedstaw analizę sumy wartości zamówień (bez
uwzględnienia zniżki) jako pełna analiza (wszystkie kombinacje) wymiarów:
• Rok (Order.OrderDate)
• Klient (Customers.CompanyName)
• Podsumowanie całościowe
Uwzględnij jedynie rekordy, które posiadają wszystkie wymagane informacje (nie potrzeba połączeń
zewnętrznych).
Wynik posortuj po nazwie Klienta (alfabetycznie).
*/

WITH 
OrderSummary AS (
	SELECT
		FORMAT(O.OrderDate, 'yyyy') AS [Year],
		C.Country,
		C.Region,
		OD.Quantity,
		OD.UnitPrice
	FROM Orders O
		JOIN [Order Details] OD 
			ON O.OrderID = OD.OrderID
		JOIN Customers C
			ON C.CustomerID = O.CustomerID
)

SELECT
	[Year],
	Country,
	Region,
	SUM(Quantity * UnitPrice) AS OrdersValue
FROM OrderSummary
GROUP BY CUBE([Year], (Country, Region))
ORDER BY Country ASC, OrdersValue DESC 