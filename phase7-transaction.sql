--  New Order Placement (tr_place_order)
-- Case 1: Successful Case (Active customer, valid product, sufficient stock)
DO $$
BEGIN
    CALL pr_place_order(2, 3, 3, 1, 'WELCOME2026');
    RAISE NOTICE 'Test 1 (Success): tr_place_order executed and committed.';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE 'Test 1 Failed: %', SQLERRM;
END $$;

-- Case 2: Unsuccessful Case 1 (Invalid/Inactive Client)
DO $$
BEGIN
    CALL pr_place_order(999, 1, 1, 1, NULL);
    RAISE NOTICE 'Test 2 (Unexpected Success): Order placed for invalid client.';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE 'Test 2 (Expected Failure): tr_place_order rolled back. Reason: %', SQLERRM;
END $$;

-- Case 3: Unsuccessful Case 2 (Insufficient Stock)
DO $$
BEGIN
    CALL pr_place_order(1, 1, 1, 9999, NULL);
    RAISE NOTICE 'Test 3 (Unexpected Success): Order placed despite low stock.';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE 'Test 3 (Expected Failure): tr_place_order rolled back. Reason: %', SQLERRM;
END $$;


--  Order Payment (tr_payment_order)


-- Case 1: Successful Case (Valid status and matching total amount)
DO $$
BEGIN
    CALL pr_register_payment(9, 5500000.00, 'ZarinPal', 'TRC-SUCCESS-009');
    RAISE NOTICE 'Test 4 (Success): tr_payment_order executed and committed.';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE 'Test 4 Failed: %', SQLERRM;
END $$;

-- Case 2: Unsuccessful Case 1 (Invalid/Insufficient Payment Amount)
DO $$
BEGIN
    CALL pr_register_payment(5, 1000.00, 'Saman', 'TRC-FAIL-05');
    RAISE NOTICE 'Test 5 (Unexpected Success): Low payment accepted.';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE 'Unsuccessful Case 1 (Invalid/Insufficient Payment Amount): Rolled back. Reason: %', SQLERRM;
END $$;

-- Case 3: Unsuccessful Case 2 (Order already processed/shipped)
DO $$
BEGIN
    CALL pr_register_payment(1, 1200000.00, 'Mellat', 'TRC-FAIL-001');
    RAISE NOTICE 'Test 6 (Unexpected Success): Paid an unpayable order.';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE 'Unsuccessful Case 2 (Order already processed/shipped): Rolled back. Reason: %', SQLERRM;
END $$;


--  Order Cancellation (tr_cancel_ord)

-- Case 1: Successful Case (Pending order cancelled, stock reverted)
DO $$
BEGIN
    CALL pr_cancel_order(12, 'Customer requested cancellation');
    RAISE NOTICE 'Test 7 (Success): tr_cancel_ord executed and committed.';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE 'Test 7 Failed: %', SQLERRM;
END $$;

-- Case 2: Unsuccessful Case 1 (Order already shipped)
DO $$
BEGIN
    CALL pr_cancel_order(2, 'Late cancellation attempt');
    RAISE NOTICE 'Test 8 (Unexpected Success): Shipped order was cancelled.';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE 'Test 8 (Expected Failure): tr_cancel_ord rolled back. Reason: %', SQLERRM;
END $$;

-- Case 3: Unsuccessful Case 2 (Order does not exist)
DO $$
BEGIN
    CALL pr_cancel_order(9999, 'Invalid order test');
    RAISE NOTICE 'Test 9 (Unexpected Success): Non-existent order cancelled.';
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE 'Test 9 (Expected Failure): tr_cancel_ord rolled back. Reason: %', SQLERRM;
END $$;