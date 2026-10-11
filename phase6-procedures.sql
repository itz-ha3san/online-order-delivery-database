--  pr_place_order
CREATE OR REPLACE PROCEDURE pr_place_order(
    IN p_customer_id INT,
    IN p_address_id INT,
    IN p_product_id INT,
    IN p_quantity INT,
    IN p_discount_code VARCHAR(50)
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_status VARCHAR(20);
    v_prod_active BOOLEAN;
    v_stock INT;
    v_price DECIMAL(12,2);
    v_discount_id INT := NULL;
    v_discount_type VARCHAR(20);
    v_discount_val DECIMAL(12,2);
    v_min_amount DECIMAL(12,2);
    v_discount_amt DECIMAL(12,2) := 0.00;
    v_total_amount DECIMAL(12,2);
    v_order_id INT;
BEGIN
    SELECT account_status INTO v_status FROM CUSTOMERS WHERE customer_id = p_customer_id;
    IF v_status IS NULL OR v_status <> 'Active' THEN
        RAISE EXCEPTION 'Order denied: Customer account is not active or does not exist.';
    END IF;

    SELECT is_active, price INTO v_prod_active, v_price FROM PRODUCTS WHERE product_id = p_product_id;
    IF v_prod_active IS NULL OR v_prod_active = FALSE THEN
        RAISE EXCEPTION 'Order denied: Product is inactive or does not exist.';
    END IF;

    SELECT quantity INTO v_stock FROM INVENTORY WHERE product_id = p_product_id;
    IF v_stock IS NULL OR v_stock < p_quantity THEN
        RAISE EXCEPTION 'Order denied: Insufficient stock available in warehouse.';
    END IF;

    v_total_amount := v_price * p_quantity;

    IF p_discount_code IS NOT NULL AND p_discount_code <> '' THEN
        SELECT discount_id, discount_type, value, min_order_amount 
        INTO v_discount_id, v_discount_type, v_discount_val, v_min_amount
        FROM DISCOUNTS 
        WHERE code = p_discount_code AND CURRENT_TIMESTAMP BETWEEN start_date AND end_date AND usage_limit > 0;
        
        IF v_discount_id IS NOT NULL THEN
            IF v_total_amount >= v_min_amount THEN
                IF v_discount_type = 'Percentage' THEN
                    v_discount_amt := v_total_amount * (v_discount_val / 100.00);
                ELSE
                    v_discount_amt := v_discount_val;
                END IF;
                
                UPDATE DISCOUNTS SET usage_limit = usage_limit - 1 WHERE discount_id = v_discount_id;
            END IF;
        END IF;
    END IF;

    v_total_amount := v_total_amount - v_discount_amt;

    INSERT INTO ORDERS (customer_id, address_id, discount_id, order_status, order_date, total_amount, shipping_cost, discount_amount)
    VALUES (p_customer_id, p_address_id, v_discount_id, 'Placed', CURRENT_TIMESTAMP, v_total_amount, 30000.00, v_discount_amt)
    RETURNING order_id INTO v_order_id;

    INSERT INTO ORDER_ITEMS (order_id, product_id, quantity, unit_price, final_price)
    VALUES (v_order_id, p_product_id, p_quantity, v_price, (v_price * p_quantity) - v_discount_amt);

    UPDATE INVENTORY 
    SET quantity = quantity - p_quantity, last_update = CURRENT_TIMESTAMP 
    WHERE product_id = p_product_id;

END;
$$;

-- pr_register_payment

CREATE OR REPLACE PROCEDURE pr_register_payment(
    IN p_order_id INT,
    IN p_amount DECIMAL(12,2),
    IN p_payment_method VARCHAR(50),
    IN p_tracking_code VARCHAR(100)
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_order_status VARCHAR(20);
    v_total_amount DECIMAL(12,2);
BEGIN
    SELECT order_status, total_amount INTO v_order_status, v_total_amount FROM ORDERS WHERE order_id = p_order_id;
    
    IF v_order_status IS NULL THEN
        RAISE EXCEPTION 'Payment denied: Order ID % does not exist.', p_order_id;
    END IF;
    
    IF v_order_status <> 'Placed' AND v_order_status <> 'Pending_Payment' THEN
        RAISE EXCEPTION 'Payment denied: Order is not in a payable state (Current status: %).', v_order_status;
    END IF;

    IF p_amount < v_total_amount THEN
        INSERT INTO PAYMENTS (order_id, amount, payment_method, payment_status, payment_time, tracking_code)
        VALUES (p_order_id, p_amount, p_payment_method, 'Failed', CURRENT_TIMESTAMP, p_tracking_code);
        
        RAISE EXCEPTION 'Payment denied: Amount paid is less than total order amount.';
    END IF;

    INSERT INTO PAYMENTS (order_id, amount, payment_method, payment_status, payment_time, tracking_code)
    VALUES (p_order_id, p_amount, p_payment_method, 'Successful', CURRENT_TIMESTAMP, p_tracking_code);

    UPDATE ORDERS SET order_status = 'Paid' WHERE order_id = p_order_id;

END;
$$;

-- pr_cancel_order

CREATE OR REPLACE PROCEDURE pr_cancel_order(
    IN p_order_id INT,
    IN p_cancellation_reason TEXT
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_order_status VARCHAR(20);
    v_prod_id INT;
    v_qty INT;
BEGIN
    SELECT order_status INTO v_order_status FROM ORDERS WHERE order_id = p_order_id;

    IF v_order_status IS NULL THEN
        RAISE EXCEPTION 'Cancellation denied: Order ID % does not exist.', p_order_id;
    END IF;

    IF v_order_status IN ('Shipped', 'Delivered') THEN
        RAISE EXCEPTION 'Cancellation denied: Cannot cancel an order that has already been shipped or delivered.';
    END IF;
    
    IF v_order_status = 'Cancelled' THEN
        RAISE EXCEPTION 'Cancellation denied: Order is already cancelled.';
    END IF;

    FOR v_prod_id, v_qty IN 
        SELECT product_id, quantity FROM ORDER_ITEMS WHERE order_id = p_order_id
    LOOP
        UPDATE INVENTORY 
        SET quantity = quantity + v_qty, last_update = CURRENT_TIMESTAMP 
        WHERE product_id = v_prod_id;
    END LOOP;

    UPDATE ORDERS 
    SET order_status = 'Cancelled'
    WHERE order_id = p_order_id;

END;
$$;