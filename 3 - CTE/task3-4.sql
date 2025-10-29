WITH 
FindReporter (
	EmployeeID,
	FirstName,
	LastName,
	ReportsTo,
	HierarchyLevel,
	ManagerFirstName,
	ManagerLastName,
	WhoIsThat
) AS (
	SELECT
		EE.EmployeeID,
		EE.FirstName,
		EE.LastName,
		EE.ReportsTo,
		0 AS HierarchyLevel,
		CAST(NULL AS NVARCHAR(10)) AS ManagerFirstName,
		CAST(NULL AS NVARCHAR(20)) AS ManagerLastName,
		CAST('Krzysiek Jarzyna' AS NVARCHAR(35)) AS WhoIsThat
	FROM Employees EE
	UNION ALL
	SELECT
		E.EmployeeID,
		E.FirstName,
		E.LastName,
		E.ReportsTo,
		(HierarchyLevel + 1) AS HierarchyLevel,
		FR.FirstName AS ManagerFirstName,
		FR.LastName AS ManagerLastName,
		CASE
            WHEN HierarchyLevel = 1 THEN cast('Tomasz Rakieta' AS NVARCHAR(35))
            ELSE cast('Ktoś inny' AS NVARCHAR(35))
        END AS WhoIsThat
	FROM 
		FindReporter FR
		INNER JOIN Employees E on E.ReportsTo = FR.EmployeeID  
)

SELECT 
	EmployeeID,
    FirstName, 
    LastName, 
    WhoIsThat AS ReportsTo, 
    ManagerFirstName,
    ManagerLastName
FROM FindReporter
