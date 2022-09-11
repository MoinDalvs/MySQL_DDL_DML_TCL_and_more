USE sql_store;
INSERT INTO customers ( 
first_name,
 last_name, 
 birth_date, 
 phone, address, 
 city, 
 state, 
 points)
 VALUES ( 'Maruf', 'Bhombal', '1997-04-27', '976-976-5676', '1010 shreeji plaza', 'Navi Mumbai', 'TX', '3699');

USE sql_store;
SELECT o.order_date, o.order_id, c.first_name, s.name AS shipper, os.name as status
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
LEFT JOIN shippers s
ON o.shipper_id = s.shipper_id
LEFT JOIN order_statuses os
ON os.order_status_id = o.status;

USE sql_hr;
SELECT 
e.employee_id,
e.first_name,
em.first_name AS manager
FROM employees e
LEFT JOIN employees em
ON e.reports_to = em.employee_id;

USE sql_store;
SELECT o.order_date, c.first_name, sh.name AS shipper
FROM orders o
JOIN customers c
USING (customer_id)
LEFT JOIN shippers sh
USING (shipper_id);

USE sql_store;
SELECT *
FROM order_items
JOIN order_item_notes
USING (order_id, product_id);

USE sql_invoicing;
SELECT p.date, c.name AS client, p.amount, pm.name AS payment_method
FROM payments p
JOIN clients c USING (client_id)
JOIN payment_methods pm
ON pm.payment_method_id = p.payment_method;

USE sql_store;
SELECT *
FROM orders o
NATURAL JOIN customers c;

USE sql_store;
SELECT p.name AS product, sh.name AS shipper
FROM products p
CROSS JOIN shippers sh
ORDER BY p.name;

USE sql_store;
SELECT order_id, order_date, 'ACTIVE' AS status
FROM orders
WHERE order_date >= '2019-01-01'
UNION
SELECT order_id, order_date, 'ARCHIVED' AS status
FROM orders
WHERE order_date < '2019-01-01';

USE sql_store;
SELECT customer_id, first_name, points, 'Bronze' AS 'Rank'
FROM customers
WHERE points < '2000'
UNION
SELECT customer_id, first_name, points, 'Silver' AS 'Rank'
FROM customers
WHERE points BETWEEN '2000' AND '3000'
UNION
SELECT customer_id, first_name, points, 'Gold' AS 'Rank'
FROM customers
WHERE points > '3000'
ORDER BY first_name;

USE sql_store;
INSERT INTO products (name, quantity_in_stock, unit_price)
VALUES ('Toothpaste', '23', '3.90' ), 
('Cold drink', '18', '3.6'), 
('Shoes', '69', '4.20');

USE sql_store;
INSERT INTO orders (customer_id, order_date, status)
VALUES (1, '2019-01-02', 2);
INSERT INTO order_items
VALUES (LAST_INSERT_ID(), 3, 34, 1.63),
(LAST_INSERT_ID(), 4, 23, 2.73);

INSERT INTO orders_archive
SELECT * 
FROM orders
WHERE order_date < '2019-01-01';

USE sql_invoicing;
CREATE TABLE invoices_archive AS
SELECT i.invoice_id,
 i.invoice_date,
 c.name as 'client name',
 i.number,
 i.payment_date,
 i.invoice_total,
 i.payment_total,
 i.due_date
FROM invoices i
JOIN clients c
USING (client_id)
WHERE payment_date IS NOT NULL;

USE sql_invoicing;
UPDATE invoices
SET payment_total = 10, payment_date = '2019-05-01'
WHERE invoice_id = 1;

USE sql_invoicing;
UPDATE invoices
SET payment_total = DEFAULT, payment_date = null
WHERE invoice_id = 1;

USE sql_invoicing;
UPDATE invoices
SET payment_total = invoice_total * 0.5, payment_date = due_date
WHERE client_id IN (3, 4);

USE sql_store;
UPDATE customers
SET points = points + 50
WHERE birth_date < '1990-01-01';

USE sql_invoicing;
UPDATE invoices
SET payment_total = 0.5 * invoicing_total,
payment_date =  due_date
WHERE client_id IN
(SELECT client_id
FROM clients
WHERE state IN ('CA', 'NY'));

USE sql_store;
UPDATE orders
SET comments = 'Gold Customer'
WHERE customer_id IN
(SELECT customer_id
FROM customers
WHERE points >= 3000);

USE sql_invoicing;
DELETE FROM invoices
WHERE client_id = (
SELECT *
FROM clients
WHERE name = 'Myworks'
);

