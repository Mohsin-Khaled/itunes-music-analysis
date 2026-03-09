USE itunes_analysis;

-- ========================================
-- CUSTOMER PURCHASE BEHAVIOR
-- ========================================

-- Query 1 - 
-- Purchase Frequncy Per Customer(highest-lowest)
SELECT 
    CustomerId,
    COUNT(InvoiceId) AS total_purchases
FROM invoice
GROUP BY CustomerId
ORDER BY total_purchases DESC;

-- Query 2 - 
-- Average Invoice Value Per Customer
SELECT 
    CustomerId,
    COUNT(InvoiceId) AS total_purchases
FROM invoice
GROUP BY CustomerId
ORDER BY total_purchases DESC;

-- Query 3 - 
-- Total Spending Per Customer
SELECT 
    CustomerId,
    AVG(Total) AS avg_purchase_value
FROM invoice
GROUP BY CustomerId
ORDER BY avg_purchase_value DESC;


-- ========================================
-- CUSTOMER RETENTION ANALYSIS
-- ========================================

-- Query 4 - 
-- Customers Buying Multiple Genre
SELECT 
    c.CustomerId,
    COUNT(DISTINCT g.GenreId) AS genres_purchased
FROM customer c
JOIN invoice i ON c.CustomerId = i.CustomerId
JOIN invoice_line il ON i.InvoiceId = il.InvoiceId
JOIN track t ON il.TrackId = t.TrackId
JOIN genre g ON t.GenreId = g.GenreId
GROUP BY c.CustomerId
HAVING genres_purchased > 1;

-- Query 5 - 
-- Customer First Purchase Date
SELECT 
    CustomerId,
    MIN(InvoiceDate) AS first_purchase
FROM invoice
GROUP BY CustomerId;

-- Query 6 - 
-- Customer Most Recent Purchase
SELECT 
    CustomerId,
    MAX(InvoiceDate) AS last_purchase
FROM invoice
GROUP BY CustomerId;


-- ========================================
-- PRODUCT PURCHASE PATTERNS
-- ========================================

-- Query 7 - 
-- Most Purchased Tracks
SELECT 
    t.Name AS track_name,
    SUM(il.Quantity) AS times_purchased
FROM invoice_line il
JOIN track t ON il.TrackId = t.TrackId
GROUP BY t.TrackId, t.Name
ORDER BY times_purchased DESC
LIMIT 10;

-- Query 8 - 
-- Most Purchased Albums
SELECT 
    t.Name AS track_name,
    SUM(il.Quantity) AS times_purchased
FROM invoice_line il
JOIN track t ON il.TrackId = t.TrackId
GROUP BY t.TrackId, t.Name
ORDER BY times_purchased DESC
LIMIT 10;

-- Query 9 - 
-- Tracks Bought Together
SELECT 
    t.Name AS track_name,
    SUM(il.Quantity) AS times_purchased
FROM invoice_line il
JOIN track t ON il.TrackId = t.TrackId
GROUP BY t.TrackId, t.Name
ORDER BY times_purchased DESC
LIMIT 10;