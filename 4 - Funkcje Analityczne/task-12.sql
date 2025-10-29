/*
Korzystając z tabeli Products oraz Categories wyświetl identyfikator produktu, kategorię, do której należy dany produkt, jednostkową cenę oraz wyliczoną sumę bieżącą jednostkowej ceny produktów w dalej kategorii. Suma bieżąca, zdefiniowana jako suma wszystkich poprzedzających rekordów (cen
8
jednostkowych produktów), powinna być wyliczona na zbiorze danych posortowanych po jednostkowej cenie produktu – rosnąco.
Wynik posortuj rosnąco wg nazwy kategorii oraz jednostkowej ceny produktu.
*/
SELECT 
	P.ProductID,
	C.CategoryName,
	P.UnitPrice,
	SUM(P.UnitPrice) OVER (
		PARTITION BY P.CategoryID
		ORDER BY P.UnitPrice
		ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
	) AS RunSum
FROM Products P
JOIN Categories C ON P.CategoryID = C.CategoryID
ORDER BY C.CategoryName, P.UnitPrice
