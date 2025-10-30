/*
Korzystając z tabel Products oraz Categories oraz funkcji analitycznych stwórz ranking najdroższych (wg jednostkowej ceny) 5 produktów w danej kategorii. W przypadku produktów o tej samej wartości na ostatniej pozycji, uwzględnij wszystkie z nich. Jeżeli był na poprzednich pozycjach to każdy z produktów jest zaliczany osobno. Wyniki posortuj wg kategorii (rosnąco) oraz miejsca w rankingu (rosnąco).
*/

WITH Ranked AS (
  SELECT
    P.ProductID,
    P.ProductName,
    C.CategoryName,
    P.UnitPrice,
    DENSE_RANK() OVER (
      PARTITION BY P.CategoryID 
      ORDER BY P.UnitPrice DESC, P.ProductID
    ) AS DenseRank
  FROM Products P
  JOIN Categories C ON P.CategoryID = C.CategoryID
),
FifthPrice AS (
  SELECT
    CategoryName,
    MIN(UnitPrice) AS ThresholdPrice
  FROM Ranked
  WHERE DenseRank <= 5
  GROUP BY CategoryName
)
SELECT
  R.ProductID,
  R.ProductName,
  R.CategoryName,
  R.UnitPrice
FROM Ranked R
JOIN FifthPrice F ON R.CategoryName = F.CategoryName
WHERE R.UnitPrice >= F.ThresholdPrice
ORDER BY R.CategoryName, R.UnitPrice DESC;