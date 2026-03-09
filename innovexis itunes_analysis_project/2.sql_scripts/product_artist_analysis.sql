
USE itunes_analysis;

-- ========================================
-- Product & Content Analysis
-- ========================================

-- Query 1: Top Revenue Generating Tracks
-- Top 10 tracks by revenue
SELECT 
    t.Name AS track_name,
    SUM(il.UnitPrice * il.Quantity) AS total_revenue
FROM invoice_line il
JOIN track t ON il.TrackId = t.TrackId
GROUP BY t.TrackId, t.Name
ORDER BY total_revenue DESC
LIMIT 10;

-- Query 2: Tracks Never Purchased
-- Tracks that were never purchased
SELECT 
    t.Name AS track_name
FROM track t
LEFT JOIN invoice_line il
ON t.TrackId = il.TrackId
WHERE il.TrackId IS NULL;

-- Query 3: Number of Tracks per Genre
-- Number of tracks per genre
SELECT 
    g.Name AS genre,
    COUNT(t.TrackId) AS total_tracks
FROM track t
JOIN genre g ON t.GenreId = g.GenreId
GROUP BY g.GenreId, g.Name
ORDER BY total_tracks DESC;


-- ========================================
-- Artist & Genre Performance
-- ========================================

-- Query 4: Top Artists by Revenue
-- Top 5 artists by revenue
SELECT 
    ar.Name AS artist_name,
    SUM(il.UnitPrice * il.Quantity) AS total_revenue
FROM invoice_line il
JOIN track t ON il.TrackId = t.TrackId
JOIN album al ON t.AlbumId = al.AlbumId
JOIN artist ar ON al.ArtistId = ar.ArtistId
GROUP BY ar.ArtistId, ar.Name
ORDER BY total_revenue DESC
LIMIT 5;

-- Query 5: Most Popular Genres
-- Top genres by number of tracks sold
SELECT 
    g.Name AS genre,
    SUM(il.Quantity) AS tracks_sold
FROM invoice_line il
JOIN track t ON il.TrackId = t.TrackId
JOIN genre g ON t.GenreId = g.GenreId
GROUP BY g.GenreId, g.Name
ORDER BY tracks_sold DESC;

-- Query 6: Genre Revenue
-- Revenue by genre
SELECT 
    g.Name AS genre,
    SUM(il.UnitPrice * il.Quantity) AS revenue
FROM invoice_line il
JOIN track t ON il.TrackId = t.TrackId
JOIN genre g ON t.GenreId = g.GenreId
GROUP BY g.GenreId, g.Name
ORDER BY revenue DESC;