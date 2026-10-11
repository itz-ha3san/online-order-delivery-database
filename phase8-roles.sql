-- ==========================================
-- Phase 8: Roles and Security
-- File: phase8-roles.sql
-- ==========================================

-- 1. Create System Roles
CREATE ROLE role_shop_admin;
CREATE ROLE role_seller;
CREATE ROLE role_support;
CREATE ROLE role_warehouse;
CREATE ROLE role_backend;

-- 2. Create Users & Assign Roles
CREATE USER admin_user WITH PASSWORD 'CHANGE_ME_BEFORE_RUNNING';
GRANT role_shop_admin TO admin_user;

CREATE USER seller_user WITH PASSWORD 'CHANGE_ME_BEFORE_RUNNING';
GRANT role_seller TO seller_user;

CREATE USER support_user WITH PASSWORD 'CHANGE_ME_BEFORE_RUNNING';
GRANT role_support TO support_user;

CREATE USER warehouse_user WITH PASSWORD 'CHANGE_ME_BEFORE_RUNNING';
GRANT role_warehouse TO warehouse_user;

CREATE USER backend_user WITH PASSWORD 'CHANGE_ME_BEFORE_RUNNING';
GRANT role_backend TO backend_user;

-- 3. Restrict DDL (Prevent structural changes by non-admins)
REVOKE CREATE ON SCHEMA public FROM PUBLIC;
GRANT CREATE ON SCHEMA public TO role_shop_admin;

-- 4. Manage Role Privileges

-- Admin: Full access to all tables and sequences
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO role_shop_admin;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO role_shop_admin;

-- Seller: Manage products & stock. No payment access. Prevent data deletion.
GRANT SELECT, INSERT, UPDATE ON PRODUCTS, INVENTORY TO role_seller;
REVOKE DELETE ON PRODUCTS, INVENTORY FROM role_seller;

-- Support: View operations. Limited update for handling complaints (e.g., order_status).
GRANT SELECT ON CUSTOMERS, ORDERS, ORDER_ITEMS, PAYMENTS TO role_support;
GRANT UPDATE (order_status) ON ORDERS TO role_support;
GRANT UPDATE (payment_status) ON PAYMENTS TO role_support;

-- Warehouse: View orders. Manage stock.
GRANT SELECT ON ORDERS, ORDER_ITEMS, PRODUCTS TO role_warehouse;
GRANT SELECT, UPDATE ON INVENTORY TO role_warehouse;

-- 5. Backend Team: Access restricted to Phase 5 Views only
GRANT SELECT ON vw_summary_orders_customer TO role_backend;
GRANT SELECT ON vw_status_sales_seller TO role_backend;
GRANT SELECT ON vw_recent_orders_30days TO role_backend;
GRANT SELECT ON vw_alerts_inventory TO role_backend;