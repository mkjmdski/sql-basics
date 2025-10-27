SELECT COUNT(*) AS CNT
FROM [Orders] O1
WHERE NOT EXISTS(
	SELECT 1
	FROM [Orders] O2
		JOIN [Employees] E
			ON O2.EmployeeID = E.EmployeeID
	WHERE 
		E.FirstName = 'Robert'
	AND E.LastName = 'King'
	AND O2.ShipRegion = O1.ShipRegion
)