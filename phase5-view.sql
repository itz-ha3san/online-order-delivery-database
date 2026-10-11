CREATE OR REPLACE VIEW vw_summary_orders_customer AS
SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    COUNT(o.order_id) AS total_orders_count,
    COALESCE(SUM(o.total_amount), 0) AS total_orders_amount,
    MAX(o.order_date) AS last_order_date
FROM CUSTOMERS c
LEFT JOIN ORDERS o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name;

CREATE OR REPLACE VIEW vw_status_sales_seller AS
SELECT 
    s.seller_id,
    s.brand_name,
    COUNT(DISTINCT o.order_id) AS successful_orders_count,
    COALESCE(SUM(oi.final_price * oi.quantity), 0) AS total_sales_amount,
    COUNT(DISTINCT p.product_id) AS active_products_count
FROM SELLERS s
LEFT JOIN PRODUCTS p ON s.seller_id = p.seller_id AND p.is_active = TRUE
LEFT JOIN ORDER_ITEMS oi ON p.product_id = oi.product_id
LEFT JOIN ORDERS o ON oi.order_id = o.order_id AND o.order_status IN ('Paid', 'Processing', 'Shipped', 'Delivered')
GROUP BY s.seller_id, s.brand_name;


CREATE OR REPLACE VIEW vw_recent_orders_30days AS
SELECT 
    o.order_id,
    o.customer_id,
    o.order_date,
    o.order_status,
    oi.order_item_id,
    oi.product_id,
    p.name AS product_name,
    oi.quantity,
    oi.unit_price,
    oi.final_price
FROM ORDERS o
JOIN ORDER_ITEMS oi ON o.order_id = oi.order_id
JOIN PRODUCTS p ON oi.product_id = p.product_id
WHERE o.order_date >= CURRENT_TIMESTAMP - INTERVAL '30 days';


CREATE OR REPLACE VIEW vw_alerts_inventory AS
SELECT 
    i.inventory_id,
    p.product_id,
    p.name AS product_name,
    s.brand_name AS seller_name,
    i.quantity AS current_stock,
    i.alert_threshold,
    i.storage_location
FROM INVENTORY i
JOIN PRODUCTS p ON i.product_id = p.product_id
JOIN SELLERS s ON p.seller_id = s.seller_id
WHERE i.quantity < i.alert_threshold;