SELECT 
	FORMAT(O.OrderDate, 'yyyy-MM-dd') as OrderDate,
	COUNT(1) AS AmountOfOrders
FROM Orders O
GROUP BY O.OrderDate
HAVING COUNT(*) > 1
ORDER BY AmountOfOrders DESC