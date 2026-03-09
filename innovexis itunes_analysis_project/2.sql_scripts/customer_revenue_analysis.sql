-- CUSTOMER ANALYTICS --
-- Top 10 Customers by spending
SELECT 
    c.CustomerId,
    CONCAT(c.FirstName,' ',c.LastName) AS customer_name,
    SUM(i.Total) AS total_spent
FROM customer c
JOIN invoice i 
ON c.CustomerId = i.CustomerId
GROUP BY c.CustomerId, customer_name
ORDER BY total_spent DESC
LIMIT 10;

-- Average Customer Lifetime value
SELECT 
    AVG(customer_total) AS avg_customer_value
FROM (
    SELECT 
        CustomerId,
        SUM(Total) AS customer_total
    FROM invoice
    GROUP BY CustomerId
);

-- Repeat vs One-Time Customers
SELECT 
    CASE 
        WHEN COUNT(i.InvoiceId) = 1 THEN 'One-time Customer'
        ELSE 'Repeat Customer'
    END AS customer_type,
    COUNT(*) AS number_of_customers
FROM customer c
JOIN invoice i ON c.CustomerId = i.CustomerId
GROUP BY c.CustomerId;


-- REVENUE ANALYSIS --
-- Total Revenue of the store
SELECT 
     SUM(Total) AS total_revenue
FROM invoice;

-- Average Invoice values
SELECT 
    AVG(Total) AS avg_invoice_value
FROM invoice;

-- Revenue By Country
SELECT 
    BillingCountry,
    SUM(Total) AS revenue
FROM invoice
GROUP BY BillingCountry
ORDER BY revenue DESC;