WITH shipped AS (
  SELECT DISTINCT shippeddate
  FROM orders
  WHERE shippeddate IS NOT NULL
),
gaps AS (
  SELECT
    shippeddate,
    LAG(shippeddate) OVER (ORDER BY shippeddate) AS prev_date
  FROM shipped
),
groups AS (
  SELECT
    shippeddate,
    CASE
      WHEN prev_date IS NULL THEN 1
      WHEN shippeddate - prev_date > 1 THEN 1
      ELSE 0
    END AS new_island_flag
  FROM gaps
),
grouped AS (
  SELECT
    shippeddate,
    SUM(new_island_flag) OVER (ORDER BY shippeddate ROWS UNBOUNDED PRECEDING) AS island_id
  FROM groups
)
SELECT
  MIN(shippeddate) AS island_start,
  MAX(shippeddate) AS island_end
FROM grouped
GROUP BY island_id
ORDER BY island_start;