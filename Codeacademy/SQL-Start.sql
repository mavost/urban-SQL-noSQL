SELECT state, 100.0 * sum(CASE WHEN elevation >= 2000 THEN 1 ELSE 0 END) / count(*) as percentage_high_elevation_airports
FROM airports
GROUP BY state;


SELECT state, 100.0 * (sum(CASE WHEN elevation >= 2000 THEN 1 ELSE 0 END)/count(*)) as percentage_high_elevation_airports 
FROM airports 
GROUP BY state;

SELECT
  *
FROM
  albums
LEFT SELECT
    CASE
        WHEN elevation < 500 THEN 'Low'
        WHEN elevation BETWEEN 500 AND 1999 THEN 'Medium'
        WHEN elevation >= 2000 THEN 'High'
        ELSE 'Unknown'
    END AS elevation_tier
    , COUNT(*)
FROM airports
GROUP BY 1;

SELECT * FROM artists WHERE id = 3;SELECT
  *
FROM
  albums
JOIN artists ON
  albums.artist_id = artists.id;