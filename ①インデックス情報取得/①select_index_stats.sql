SELECT 
    '&1.'
  , name
  , height
  , lf_rows
  , del_lf_rows
  , del_lf_rows / NULLIF(lf_rows, 0) AS ratio
  , CASE 
      WHEN 
        height >= 4 
        AND del_lf_rows / NULLIF(lf_rows, 0) > 0.2 
      THEN 1
      ELSE 0 
    END AS flag 
FROM 
  index_stats
;
