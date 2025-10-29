SELECT 
	O.ShipCountry,
	O.ShipRegion,
	O.ShipCity,
	COUNT(*),
	(
		CASE GROUPING_ID (O.ShipCountry, O.ShipRegion, O.ShipCity)
			WHEN 0 THEN 'Country & Region & City'
			WHEN 1 THEN 'Country & Region'
			WHEN 2 THEN 'Country & City'
			WHEN 3 THEN 'Country'
			WHEN 4 THEN 'Region & City'
			WHEN 5 THEN 'Region'
			WHEN 6 THEN 'City'
			WHEN 7 THEN 'Total'
		END
	) AS GroupingLevelManual,
  CONCAT_WS(
    ' & ',
    CASE WHEN GROUPING(O.ShipCountry) = 0 THEN 'Country' END,
    CASE WHEN GROUPING(O.ShipRegion) = 0 THEN 'Region' END,
    CASE WHEN GROUPING(O.ShipCity) = 0 THEN 'City' END
  ) AS GroupingLevelAutomated
FROM Orders O
GROUP BY ROLLUP(
	O.ShipCountry,
	O.ShipRegion,
	O.ShipCity
)
ORDER BY O.ShipCountry ASC