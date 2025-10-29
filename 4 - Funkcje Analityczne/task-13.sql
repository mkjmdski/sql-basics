/*
Rozbuduj poprzednie zapytanie o wyliczenie maksymalnej wartości ceny jednostkowej z okna obejmującego 2 poprzednie wiersze i 2 następujące po bieżącym. Dodatkowo wylicz średnią kroczącą z ceny jednostkowej składającej się z okna obejmującego 2 poprzednie rekordy oraz aktualny. Nie zmieniaj sortowania – wszystkie zbiory powinny być uporządkowane rosnąco po cenie jednostkowej produktu.
Wynik końcowy powinien być posortowany rosnąco wg nazwy kategorii oraz jednostkowej ceny produktu.
*/
SELECT 
	P.ProductID,
	C.CategoryName,
	P.UnitPrice,
	SUM(P.UnitPrice) OVER (
		PARTITION BY P.CategoryID
		ORDER BY P.UnitPrice ASC, P.ProductID
		ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
	) AS RunSum,
	ROUND(AVG(P.UnitPrice) OVER (
		PARTITION BY P.CategoryID
		ORDER BY P.UnitPrice ASC, P.ProductID
		ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
	), 2) AS MovAvg,
	MAX(P.UnitPrice) OVER (
		PARTITION BY P.CategoryID
		ORDER BY P.UnitPrice ASC, P.ProductID
		ROWS BETWEEN 2 PRECEDING AND 2 FOLLOWING
	) AS MaxOfFour
FROM Products P
JOIN Categories C ON P.CategoryID = C.CategoryID
ORDER BY C.CategoryName, P.UnitPrice ASC
