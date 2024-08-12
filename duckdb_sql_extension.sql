FROM netflix_daily_top_10;
SHOW netflix_daily_top_10;
-- Display the most popular TV Shows
SELECT Title,
    max("Days In Top 10")
from netflix_daily_top_10
where Type = 'TV Show'
GROUP BY Title
ORDER BY max("Days In Top 10") desc
limit 5;
-- Display the most popular TV Shows
SELECT Title,
    max("Days In Top 10")
from netflix_daily_top_10
where Type = 'Movie'
GROUP BY Title
ORDER BY max("Days In Top 10") desc
limit 5;