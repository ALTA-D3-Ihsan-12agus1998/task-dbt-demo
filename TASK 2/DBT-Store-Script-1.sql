----------Metode Subquery----------(akan disimpan di Views)
CREATE VIEW sales_sum AS
SELECT 
    o.order_date::date AS order_date
    , p.name AS product_name
    , b.name AS brand_name
    , od.quantity AS qty_sold
    , od.price AS revenue
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
JOIN brands b ON p.brand_id = b.brand_id;

SELECT *
FROM sales_sum;



----------Metode CTE----------
WITH order_details_cte AS (
    SELECT 
        o.order_id
        , o.order_date::date AS order_date
        , od.product_id
        , od.quantity AS qty_sold
        , od.price AS revenue
    FROM orders o
    JOIN order_details od ON o.order_id = od.order_id
)
,
product_details_cte AS (
    SELECT 
        p.product_id
        , p.name AS product_name
        , b.name AS brand_name
    FROM products p
    JOIN brands b ON p.brand_id = b.brand_id
)
SELECT 
    odc.order_date
    , pdc.product_name
    , pdc.brand_name
    , odc.qty_sold
    , odc.revenue
FROM order_details_cte odc
JOIN product_details_cte pdc ON odc.product_id = pdc.product_id
LIMIT 16;
