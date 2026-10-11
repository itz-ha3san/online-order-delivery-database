CREATE TABLE CUSTOMERS (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone VARCHAR(15) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    registration_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    account_status VARCHAR(20) NOT NULL DEFAULT 'Active' 
        CONSTRAINT chk_customer_status CHECK (account_status IN ('Active', 'Suspended', 'Deactivated'))
);

CREATE TABLE CUSTOMER_ADDRESSES (
    address_id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL,
    title VARCHAR(50) NOT NULL, 
    address_text TEXT NOT NULL,
    postal_code VARCHAR(10) NOT NULL,
    CONSTRAINT fk_address_customer FOREIGN KEY (customer_id) 
        REFERENCES CUSTOMERS(customer_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE SELLERS (
    seller_id SERIAL PRIMARY KEY,
    brand_name VARCHAR(100) NOT NULL,
    economic_code VARCHAR(50) NOT NULL UNIQUE,
    phone VARCHAR(15) NOT NULL,
    email VARCHAR(100) NOT NULL,
    verification_status VARCHAR(20) NOT NULL DEFAULT 'Pending'
        CONSTRAINT chk_seller_status CHECK (verification_status IN ('Pending', 'Approved', 'Rejected')),
    join_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE CATEGORIES (
    category_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    parent_category_id INT,
    CONSTRAINT fk_category_parent FOREIGN KEY (parent_category_id) 
        REFERENCES CATEGORIES(category_id) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE PRODUCTS (
    product_id SERIAL PRIMARY KEY,
    seller_id INT NOT NULL,
    category_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(12, 2) NOT NULL CONSTRAINT chk_product_price CHECK (price >= 0),
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    CONSTRAINT fk_product_seller FOREIGN KEY (seller_id) 
        REFERENCES SELLERS(seller_id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_product_category FOREIGN KEY (category_id) 
        REFERENCES CATEGORIES(category_id) ON DELETE RESTRICT ON UPDATE CASCADE
);


CREATE TABLE INVENTORY (
    inventory_id SERIAL PRIMARY KEY,
    product_id INT NOT NULL UNIQUE,
    quantity INT NOT NULL DEFAULT 0 CONSTRAINT chk_inv_quantity CHECK (quantity >= 0),
    alert_threshold INT NOT NULL DEFAULT 5 CONSTRAINT chk_inv_threshold CHECK (alert_threshold >= 0),
    storage_location VARCHAR(50),
    last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_inventory_product FOREIGN KEY (product_id) 
        REFERENCES PRODUCTS(product_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE DISCOUNTS (
    discount_id SERIAL PRIMARY KEY,
    code VARCHAR(50) NOT NULL UNIQUE,
    discount_type VARCHAR(20) NOT NULL 
        CONSTRAINT chk_discount_type CHECK (discount_type IN ('Percentage', 'Fixed_Amount')),
    value DECIMAL(12, 2) NOT NULL CONSTRAINT chk_discount_value CHECK (value > 0),
    start_date TIMESTAMP NOT NULL,
    end_date TIMESTAMP NOT NULL,
    usage_limit INT CONSTRAINT chk_discount_limit CHECK (usage_limit > 0),
    min_order_amount DECIMAL(12, 2) DEFAULT 0 CONSTRAINT chk_discount_min CHECK (min_order_amount >= 0),
    CONSTRAINT chk_discount_dates CHECK (end_date > start_date)
);

CREATE TABLE ORDERS (
    order_id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL,
    address_id INT NOT NULL,
    discount_id INT, 
    order_status VARCHAR(30) NOT NULL DEFAULT 'Placed'
        CONSTRAINT chk_order_status CHECK (order_status IN ('Placed', 'Pending_Payment', 'Paid', 'Processing', 'Shipped', 'Delivered', 'Cancelled')),
    order_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(12, 2) NOT NULL DEFAULT 0 CONSTRAINT chk_order_total CHECK (total_amount >= 0),
    shipping_cost DECIMAL(12, 2) NOT NULL DEFAULT 0 CONSTRAINT chk_order_shipping CHECK (shipping_cost >= 0),
    discount_amount DECIMAL(12, 2) NOT NULL DEFAULT 0 CONSTRAINT chk_order_discount CHECK (discount_amount >= 0),
    CONSTRAINT fk_order_customer FOREIGN KEY (customer_id) 
        REFERENCES CUSTOMERS(customer_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_order_address FOREIGN KEY (address_id) 
        REFERENCES CUSTOMER_ADDRESSES(address_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_order_discount FOREIGN KEY (discount_id) 
        REFERENCES DISCOUNTS(discount_id) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE ORDER_ITEMS (
    order_item_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CONSTRAINT chk_item_quantity CHECK (quantity > 0),
    unit_price DECIMAL(12, 2) NOT NULL CONSTRAINT chk_item_unit_price CHECK (unit_price >= 0),
    final_price DECIMAL(12, 2) NOT NULL CONSTRAINT chk_item_final_price CHECK (final_price >= 0),
    CONSTRAINT fk_item_order FOREIGN KEY (order_id) 
        REFERENCES ORDERS(order_id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_item_product FOREIGN KEY (product_id) 
        REFERENCES PRODUCTS(product_id) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE PAYMENTS (
    payment_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL,
    amount DECIMAL(12, 2) NOT NULL CONSTRAINT chk_payment_amount CHECK (amount > 0),
    payment_method VARCHAR(30) NOT NULL,
    payment_status VARCHAR(30) NOT NULL DEFAULT 'Pending'
        CONSTRAINT chk_payment_status CHECK (payment_status IN ('Pending', 'Successful', 'Failed')),
    payment_time TIMESTAMP,
    tracking_code VARCHAR(100) UNIQUE,
    CONSTRAINT fk_payment_order FOREIGN KEY (order_id) 
        REFERENCES ORDERS(order_id) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE SHIPPING (
    shipping_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL UNIQUE,
    shipping_company VARCHAR(50) NOT NULL,
    tracking_code VARCHAR(100) UNIQUE,
    shipping_time TIMESTAMP,
    delivery_time TIMESTAMP,
    shipping_status VARCHAR(30) NOT NULL DEFAULT 'Pending'
        CONSTRAINT chk_shipping_status CHECK (shipping_status IN ('Pending', 'In_Transit', 'Delivered', 'Returned')),
    CONSTRAINT fk_shipping_order FOREIGN KEY (order_id) 
        REFERENCES ORDERS(order_id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT chk_shipping_dates CHECK (delivery_time >= shipping_time)
);