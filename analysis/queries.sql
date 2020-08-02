-- QUERIES

'''
Note: ROUND() function was used with AVG() function to calculate average values.
pgAdmin4 has a bug where AVG() does not work on its own but does work
in combination with ROUND(). See https://www.postgresql.org/message-id/CAJbBuK3oRaCJn_XrwR5XZDNAzSmsdDOv3T%2Bc4TSmpEVAoDj%2B3w%40mail.gmail.com
for a communication thread on the issue. Thanks!
'''

-- total # review ids
SELECT COUNT(review_id)
FROM vine_table;
-- answer: 3,093,869 (really 3,093,861 because 8 are not 'N' or 'Y' for vine)

-- most recent review
SELECT review_date
FROM review_id_table
ORDER BY review_date DESC;
-- answer: 2015-08-31

-- oldest review
SELECT review_date
FROM review_id_table
ORDER BY review_date ASC;
-- answer: 1999-06-09

-- # of reviews, V vs NV
SELECT vine, 
    COUNT(review_id)
FROM vine_table
GROUP BY vine;
-- answer: 18,512 (V) and 3,075,349 (NV)

-- avg # reviews per customer id, grouped by V vs NV
SELECT v.vine,
    ROUND(AVG(c.customer_count))
FROM vine_table as v
INNER JOIN review_id_table as r
ON v.review_id = r.review_id
INNER JOIN customers as c
ON r.customer_id = c.customer_id
GROUP BY vine;
-- answer: 18 (V) and 3 (NV)

-- avg star rating, V vs NV
SELECT vine,
    ROUND(AVG(star_rating))
FROM vine_table
GROUP BY vine;
-- answer: 4 (V) and 4 (NV)

-- Avg # of helpful votes per review id, V vs NV 
-- (no total vote/review threshold)
SELECT vine, 
    ROUND(AVG(helpful_votes))
FROM vine_table
GROUP BY vine;
-- answer: 6 (V) and 2 (NV)

-- Avg # of helpful votes per review id, V vs NV
-- (total votes/review must be > 29)
SELECT vine, 
    ROUND(AVG(helpful_votes))
FROM vine_table
WHERE total_votes > 29
GROUP BY vine;
-- answer: 91 (V) and 78 (NV)

-- # of 5-star reviews, V vs NV
SELECT vine,
    COUNT(review_id)
FROM vine_table
WHERE star_rating = 5
GROUP BY vine;
-- answer: 8,044 (V) vs 1,773,112 (NV)

-- # of 4-star reviews, V vs NV
SELECT vine,
    COUNT(review_id)
FROM vine_table
WHERE star_rating = 4
GROUP BY vine;
-- answer: 6,539 (V) vs 530,280 (NV)

-- # of 3-star reviews, V vs NV
SELECT vine,
    COUNT(review_id)
FROM vine_table
WHERE star_rating = 3
GROUP BY vine;
-- answer: 2,656 (V) vs 235,931 (NV)

-- # of 2-star reviews, V vs NV
SELECT vine,
    COUNT(review_id)
FROM vine_table
WHERE star_rating = 2
GROUP BY vine;
-- answer: 931 (V) vs 178,249 (NV)

-- # of 1-star reviews, V vs NV
SELECT vine,
    COUNT(review_id)
FROM vine_table
WHERE star_rating = 1
GROUP BY vine;
-- answer: 342 (V) vs 357,777 (NV)

-- Note: sum of #-star reviews = 3,093,861