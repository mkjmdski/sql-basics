WITH
GetOrderDates AS ( 
SELECT
	FORMAT(O.OrderDate, 'yyyy') as 'Year',
	FORMAT(O.OrderDate, 'yyyy-MM') as 'YearMonth'
FROM Orders O
)
SELECT
	Year,
	YearMonth,
	COUNT(*)
FROM GetOrderDates
GROUP BY ROLLUP(Year, YearMonth)
ORDER BY YearMonth DESC