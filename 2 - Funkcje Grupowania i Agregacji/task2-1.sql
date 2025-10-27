WITH
MaxUnitPrice as (
	SELECT MAX(P.UnitPrice) as UnitPrice
	FROM Products P
	GROUP BY P.ProductID, P.UnitPrice
)
SELECT MAX(UnitPrice) FROM MaxUnitPrice
