CREATE INDEX idx_orders_customer_date 
ON ORDERS (customer_id, order_date DESC);

CREATE INDEX idx_inventory_low_stock 
ON INVENTORY (product_id) 
WHERE quantity < alert_threshold;

CREATE INDEX idx_orders_analytics 
ON ORDERS (order_date, order_status);