WITH shipped AS (
  SELECT DISTINCT shippeddate
  FROM orders
  WHERE shippeddate IS NOT NULL
),
gaps AS (
  SELECT
    shippeddate,
    LAG(shippeddate) OVER (ORDER BY shippeddate) AS prev_date,
    DATEDIFF(DAY, LAG(shippeddate) OVER (ORDER BY shippeddate), shippeddate) AS gap_days
  FROM shipped
)
SELECT
  prev_date AS gap_start,
  shippeddate AS gap_end,
  gap_days
FROM gaps
WHERE gap_days >= 2
ORDER BY gap_start;
