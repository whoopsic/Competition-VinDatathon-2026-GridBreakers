-- Q1
SELECT AVG(gap) AS median_gap
FROM (
    SELECT
        DATEDIFF(order_date,
            LAG(order_date) OVER (PARTITION BY customer_id ORDER BY order_date)
        ) AS gap,
        ROW_NUMBER() OVER (ORDER BY DATEDIFF(order_date,
            LAG(order_date) OVER (PARTITION BY customer_id ORDER BY order_date)
        )) AS rn,
        COUNT(*) OVER () AS cnt
    FROM orders
) t
WHERE gap IS NOT NULL
AND rn IN (FLOOR((cnt + 1)/2), FLOOR((cnt + 2)/2));

-- Q2
SELECT
    segment,
    AVG((price - cogs) / NULLIF(price, 0)) AS avg_profit_margin
FROM products
GROUP BY segment
ORDER BY avg_profit_margin DESC
LIMIT 1;

-- Q3
SELECT 
    r.return_reason, 
    COUNT(r.return_reason) AS result
FROM returns r 
LEFT JOIN products p ON r.product_id = p.product_id
WHERE category = 'Streetwear'
GROUP BY r.return_reason
ORDER BY result DESC
LIMIT 1

-- Q4
SELECT 
    traffic_source, 
    AVG(bounce_rate) AS result
FROM web_traffic
GROUP BY traffic_source
ORDER BY result ASC
LIMIT 1

-- Q5
SELECT 
    AVG(CASE WHEN promo_id IS NOT NULL THEN 100.0 ELSE 0 END) AS promo_percentage
FROM order_items;

-- Q6
WITH result AS (
    SELECT c.customer_id, COUNT(oi.order_id) AS num_of_orders
    FROM customers c
    LEFT JOIN orders oi ON c.customer_id = oi.customer_id
    GROUP BY c.customer_id
)
SELECT 
    c.age_group, 
    SUM(r.num_of_orders)/COUNT(*) AS num_of_cust
FROM result r 
LEFT JOIN customers c ON r.customer_id = c.customer_id
GROUP BY c.age_group
ORDER BY num_of_cust DESC
LIMIT 1

-- Q7
SELECT 
    g.region, 
    SUM(o2.unit_price*o2.quantity)
FROM geography g
LEFT JOIN orders o1 on g.zip = o1.zip
LEFT JOIN order_items o2 on o1.order_id = o2.order_id
WHERE order_date BETWEEN '2012/04/07' AND '2022/12/31'
--AND order_status NOT IN ('returned', 'cancelled')
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1

--- Check revenue mapped with sales
SELECT 
    SUM(o2.unit_price*o2.quantity) as manual_calculation,
    (
        SELECT SUM(revenue)
        FROM sales
        WHERE date BETWEEN '2012/04/07' AND '2022/12/31'
    ) as from_sale_table
FROM geography g
LEFT JOIN orders o1 on g.zip = o1.zip
LEFT JOIN order_items o2 on o1.order_id = o2.order_id
-- WHERE order_status NOT IN ('returned', 'cancelled')
WHERE order_date BETWEEN '2012/04/07' AND '2022/12/31'
--> match

-- Q8
SELECT 
    payment_method, 
    COUNT(*) as cnt
FROM orders
WHERE order_status = 'cancelled'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1

-- Q9
-- Using return table
SELECT 
    size,
    COUNT(*) as total_cnt,
    COUNT(return_id) as return_cnt,
    COUNT(return_id)*1.0/COUNT(*) as return_rate
FROM order_items o
LEFT JOIN products p on o.product_id = p.product_id
LEFT JOIN returns r on r.order_id = o.order_id and p.product_id = r.product_id
GROUP BY 1
ORDER BY 4 DESC
LIMIT 1
-- Using status
SELECT size,
    COUNT(*) as total_cnt,
    COUNT(CASE WHEN order_status ='returned' THEN 1 END) as return_cnt,
    COUNT(CASE WHEN order_status ='returned' THEN 1 END)*1.0/COUNT(*) as return_rate
FROM order_items o
LEFT JOIN products p on o.product_id = p.product_id
LEFT JOIN orders o2 on o2.order_id = o.order_id
GROUP BY 1
ORDER BY 4 DESC
LIMIT 1

-- Q10
SELECT 
    installments, 
    AVG(payment_value)
FROM payments
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1