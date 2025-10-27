SELECT ShipCountry FROM Orders WHERE ShipRegion IS NULL
INTERSECT
SELECT ShipCountry FROM Orders Where ShipRegion IS NOT NULL;