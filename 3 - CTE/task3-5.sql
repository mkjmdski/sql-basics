WITH 
Fibonacci (Num, Val, NextVal) AS (
 SELECT
  0 AS Num,
  0 AS Val,
  1 AS NextVal
 UNION ALL
 SELECT
  Num + 1,
  NextVal,
  Val + NextVal
 FROM Fibonacci
 WHERE Num + 1 <= 20
)
SELECT Num, Val
FROM Fibonacci

OPTION (MAXRECURSION 20);
