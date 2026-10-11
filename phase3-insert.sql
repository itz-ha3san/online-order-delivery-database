INSERT INTO CUSTOMERS (first_name, last_name, phone, email, registration_date, account_status) VALUES
('علی', 'رضایی', '09121111111', 'ali@gmail.com', '2026-01-01 10:00:00', 'Active'),
('رضا', 'احمدی', '09122222222', 'reza@gmail.com', '2026-01-05 11:30:00', 'Active'),
('سارا', 'کیمیایی', '09123333333', 'sara@gmail.com', '2026-02-10 14:15:00', 'Active'),
('مریم', 'حسینی', '09124444444', 'maryam@gmail.com', '2026-03-01 09:00:00', 'Active'),
('محمد', 'کریمی', '09125445555', 'mohammad@gmail.com', '2026-03-15 16:45:00', 'Active'),
('امیر', 'صادقی', '09126666666', 'amir@gmail.com', '2026-04-02 12:00:00', 'Suspended'),
('زهرا', 'علوی', '09127777777', 'zahra@gmail.com', '2026-05-10 18:20:00', 'Active'),
('حسین', 'مرادی', '09128888888', 'hossein@gmail.com', '2026-06-01 21:00:00', 'Active'),
('نیلوفر', 'کاظمی', '09129999999', 'niloofar@gmail.com', '2026-06-20 11:10:00', 'Active'),
('مهدی', 'هاشمی', '09120000000', 'mehdi@gmail.com', '2026-07-01 15:30:00', 'Active');

INSERT INTO CUSTOMER_ADDRESSES (customer_id, title, address_text, postal_code) VALUES
(1, 'خانه', 'تهران، خیابان ولیعصر، کوچه ۱', '1111111111'),
(1, 'محل کار', 'تهران، دانشگاه امیرکبیر، دانشکده کامپیوتر', '1111122222'),
(2, 'خانه', 'شیراز، خیابان ارم، پلاک ۴', '2222233333'),
(3, 'خانه', 'اصفهان، چهارباغ عباسی، کوچه مریم', '3333344444'),
(4, 'خانه', 'مشهد، بلوار وکیل آباد، خیابان صدف', '4444455555'),
(5, 'خانه', 'تبریز، خیابان امام، پلاک ۱۰', '5555566666'),
(7, 'خانه', 'کرج، جهانشهر، کوچه لاله', '7777788888'),
(8, 'محل کار', 'تهران، سیدخندان، پلاک ۱۲', '8888899999'),
(9, 'خانه', 'رشت، گلسار، خیابان ۱00', '9999900000'),
(10, 'خانه', 'اهواز، کیانپارس، خیابان اسفند', '6666677777');

INSERT INTO SELLERS (brand_name, economic_code, phone, email, verification_status, join_date) VALUES
('دیجی کالا', 'ECO-1001', '02161111', 'info@digikala.com', 'Approved', '2026-01-01 08:00:00'),
('تکنولایف', 'ECO-1002', '02162222', 'info@technolife.com', 'Approved', '2026-01-10 09:00:00'),
('کتاب فروشی رشد', 'ECO-1003', '02163333', 'roshd@gmail.com', 'Approved', '2026-02-01 10:00:00'),
('مهرگان استور', 'ECO-1004', '02164444', 'mehregan@gmail.com', 'Pending', '2026-03-01 11:00:00'),
('شیک پوش', 'ECO-1005', '02165555', 'shikpoosh@gmail.com', 'Approved', '2026-03-15 12:00:00'),
('اسنپ مارکت', 'ECO-1006', '02166666', 'snapp@market.com', 'Approved', '2026-04-01 13:00:00'),
('ابزارآلات آروا', 'ECO-1007', '02167777', 'arva@gmail.com', 'Rejected', '2026-04-15 14:00:00'),
('چرم مشهد', 'ECO-1008', '02168888', 'mashhadleather@com', 'Approved', '2026-05-01 15:00:00'),
('هایپر کالا', 'ECO-1009', '02169999', 'hyper@gmail.com', 'Approved', '2026-05-15 16:00:00'),
('اسپورت لند', 'ECO-1010', '02160000', 'sportland@gmail.com', 'Approved', '2026-06-01 17:00:00');

INSERT INTO CATEGORIES (name, parent_category_id) VALUES
('کالای دیجیتال', NULL),     
('کتاب و لوازم التحریر', NULL),
('پوشاک', NULL),             
('موبایل', 1),                
('لپ تاپ', 1),                
('رمان', 2),                  
('کفش', 3),                   
('کفش ورزشی', 7),             
('سوپرمارکت', NULL),          
('لبنیات', 9);                

INSERT INTO PRODUCTS (seller_id, category_id, name, description, price, is_active) VALUES
(1, 4, 'iPhone 15 Pro', 'اپل آیفون ۱۵ پرو ۱۲۸ گیگابایت', 60000000.00, TRUE),
(1, 5, 'ASUS ROG Laptop', 'لپ تاپ گیمینگ ایسوس گیم ردی', 85000000.00, TRUE),
(2, 4, 'Samsung S24 Ultra', 'سامسونگ گلکسی اس ۲۴ اولترا', 65000000.00, TRUE),
(3, 6, 'کتاب پایگاه داده', 'کتاب مرجع پایگاه داده‌ها', 250000.00, TRUE),
(5, 7, 'کاپشن چرم', 'کاپشن چرم طبیعی مشکی رنگ', 4500000.00, TRUE),
(6, 10, 'شیر کم چرب کاله', 'شیر ۱ لیتری کم چرب کاله', 35000.00, TRUE),
(8, 7, 'کفش رسمی مردانه', 'کفش تمام چرم مجلسی', 3200000.00, TRUE),
(9, 9, 'برنج ایرانی ۱۰ کیلوگرم', 'برنج هاشمی درجه یک', 1200000.00, TRUE),
(10, 8, 'کتانی نایک ایرمکس', 'کتانی مخصوص دویدن', 5500000.00, TRUE),
(2, 4, 'Xiaomi Redmi Note 13', 'شیائومی ردمی نوت ۱۳', 12000000.00, TRUE);

INSERT INTO INVENTORY (product_id, quantity, alert_threshold, storage_location, last_update) VALUES
(1, 15, 3, 'A-101', '2026-07-01 09:00:00'),
(2, 2, 3, 'A-102', '2026-07-01 09:15:00'),
(3, 20, 5, 'A-103', '2026-07-02 10:00:00'),
(4, 50, 10, 'B-201', '2026-07-02 11:00:00'),
(5, 8, 2, 'C-301', '2026-07-03 14:00:00'),
(6, 100, 15, 'D-101', '2026-07-04 08:30:00'),
(7, 12, 4, 'C-302', '2026-07-04 16:00:00'),
(8, 4, 5, 'D-102', '2026-07-05 12:00:00'), 
(9, 25, 6, 'E-101', '2026-07-06 10:00:00'),
(10, 30, 8, 'A-104', '2026-07-06 11:30:00');

INSERT INTO DISCOUNTS (code, discount_type, value, start_date, end_date, usage_limit, min_order_amount) VALUES
('WELCOME', 'Percentage', 10.00, '2026-01-01 00:00:00', '2026-12-31 23:59:59', 1000, 100000.00),
('SUMMER1405', 'Fixed_Amount', 500000.00, '2026-06-01 00:00:00', '2026-08-31 23:59:59', 500, 2000000.00),
('AUTUMN', 'Percentage', 15.00, '2026-09-01 00:00:00', '2026-11-30 23:59:59', 200, 1500000.00),
('YALDA', 'Percentage', 20.00, '2026-12-20 00:00:00', '2026-12-22 23:59:59', 100, 500000.00),
('EID1405', 'Fixed_Amount', 1000000.00, '2026-03-20 00:00:00', '2026-04-05 23:59:59', 300, 4000000.00),
('SUPERMARKET', 'Percentage', 5.00, '2026-05-01 00:00:00', '2026-08-01 23:59:59', 1000, 200000.00),
('TECH5', 'Percentage', 5.00, '2026-07-01 00:00:00', '2026-07-31 23:59:59', 100, 10000000.00),
('BOOK20', 'Percentage', 20.00, '2026-02-01 00:00:00', '2026-04-01 23:59:59', 150, 50000.00),
('FASHION', 'Fixed_Amount', 300000.00, '2026-04-10 00:00:00', '2026-05-10 23:59:59', 200, 1000000.00),
('SPECIAL_OFFER', 'Fixed_Amount', 2000000.00, '2026-07-10 00:00:00', '2026-07-20 23:59:59', 50, 15000000.00);


INSERT INTO ORDERS (customer_id, address_id, discount_id, order_status, order_date, total_amount, shipping_cost, discount_amount) VALUES
(1, 1, 7, 'Delivered', '2026-07-01 14:00:00', 57000000.00, 50000.00, 3000000.00),
(1, 1, NULL, 'Shipped', '2026-07-15 11:00:00', 85000000.00, 0.00, 0.00),
(1, 2, NULL, 'Placed', '2026-07-18 16:30:00', 250000.00, 30000.00, 0.00),
(1, 1, NULL, 'Cancelled', '2026-07-10 10:00:00', 12000000.00, 50000.00, 0.00),
(1, 1, NULL, 'Pending_Payment', '2026-07-19 09:00:00', 4500000.00, 40000.00, 0.00),
(2, 3, 2, 'Delivered', '2026-06-15 12:00:00', 64500000.00, 0.00, 500000.00),
(3, 4, NULL, 'Paid', '2026-07-14 15:00:00', 3200000.00, 45000.00, 0.00),
(4, 5, 6, 'Delivered', '2026-07-05 18:00:00', 1140000.00, 35000.00, 60000.00),
(5, 6, NULL, 'Pending_Payment', '2026-07-19 11:15:00', 5500000.00, 50000.00, 0.00),
(7, 7, NULL, 'Delivered', '2026-07-02 13:00:00', 70000.00, 30000.00, 0.00);

INSERT INTO ORDER_ITEMS (order_id, product_id, quantity, unit_price, final_price) VALUES
(1, 1, 1, 60000000.00, 57000000.00),
(2, 2, 1, 85000000.00, 85000000.00),
(3, 4, 1, 250000.00, 250000.00),
(4, 10, 1, 12000000.00, 12000000.00),
(5, 5, 1, 4500000.00, 4500000.00),
(6, 3, 1, 65000000.00, 64500000.00),
(7, 7, 1, 3200000.00, 3200000.00),
(8, 8, 1, 1200000.00, 1140000.00),
(9, 9, 1, 5500000.00, 5500000.00),
(10, 6, 2, 35000.00, 70000.00);

INSERT INTO PAYMENTS (order_id, amount, payment_method, payment_status, payment_time, tracking_code) VALUES
(1, 57050000.00, 'Online', 'Successful', '2026-07-01 14:05:00', 'TRK-PAY-001'),
(2, 85000000.00, 'Online', 'Successful', '2026-07-15 11:02:00', 'TRK-PAY-002'),
(4, 12050000.00, 'Online', 'Failed', '2026-07-10 10:02:00', 'TRK-PAY-004'),
(5, 4540000.00, 'Online', 'Failed', '2026-07-19 09:05:00', 'TRK-PAY-005'),
(6, 64500000.00, 'Online', 'Successful', '2026-06-15 12:10:00', 'TRK-PAY-006'),
(7, 32450000.00, 'Online', 'Successful', '2026-07-14 15:05:00', 'TRK-PAY-007'),
(8, 1175000.00, 'Online', 'Successful', '2026-07-05 18:05:00', 'TRK-PAY-008'),
(10, 100000.00, 'Online', 'Successful', '2026-07-02 13:02:00', 'TRK-PAY-010');

INSERT INTO SHIPPING (order_id, shipping_company, tracking_code, shipping_time, delivery_time, shipping_status) VALUES
(1, 'Tipax', 'SHP-1001', '2026-07-02 09:00:00', '2026-07-04 14:00:00', 'Delivered'),
(2, 'Post', 'SHP-1002', '2026-07-16 10:00:00', NULL, 'In_Transit'),
(6, 'Tipax', 'SHP-1006', '2026-06-16 09:00:00', '2026-06-18 11:00:00', 'Delivered'),
(8, 'SnappBox', 'SHP-1008', '2026-07-06 08:00:00', '2026-07-06 10:00:00', 'Delivered'),
(10, 'Yandex', 'SHP-1010', '2026-07-02 15:00:00', '2026-07-02 16:00:00', 'Delivered');



SELECT * 
FROM ORDERS 
WHERE customer_id = 1;

SELECT * 
FROM ORDERS 
WHERE customer_id = 1 
ORDER BY order_date DESC 
LIMIT 5;

SELECT p.product_id, p.name, i.quantity, i.alert_threshold, i.storage_location
FROM PRODUCTS p
JOIN INVENTORY i ON p.product_id = i.product_id
WHERE i.quantity < i.alert_threshold;

SELECT s.seller_id, s.brand_name, SUM(oi.final_price * oi.quantity) AS total_sales
FROM SELLERS s
JOIN PRODUCTS p ON s.seller_id = p.seller_id
JOIN ORDER_ITEMS oi ON p.product_id = oi.product_id
JOIN ORDERS o ON oi.order_id = o.order_id
WHERE o.order_status IN ('Paid', 'Processing', 'Shipped', 'Delivered')
  AND o.order_date >= '2026-06-19 00:00:00' -- ۳۰ روز قبل از زمان حال پروژه
GROUP BY s.seller_id, s.brand_name
HAVING SUM(oi.final_price * oi.quantity) > 50000000.00;

SELECT o.order_id, o.customer_id, o.order_status, o.total_amount, p.payment_status
FROM ORDERS o
LEFT JOIN PAYMENTS p ON o.order_id = p.order_id
WHERE o.order_status = 'Pending_Payment' 
   OR p.payment_status = 'Failed';

SELECT COUNT(*) AS total_orders_last_month
FROM ORDERS
WHERE order_date >= '2026-06-19 00:00:00' 
  AND order_date <= '2026-07-19 23:59:59';