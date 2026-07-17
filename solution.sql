-- Solucao: Relatorio de Vendas
-- Testado em SQLite. Para Postgres/MySQL: trocar strftime()/date() pelas
-- funcoes equivalentes (DATE_TRUNC / DATE_FORMAT / INTERVAL).

-- 1. Receita total por cliente
SELECT
    c.name AS customer_name,
    SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM customers c
JOIN orders o ON o.customer_id = c.id
JOIN order_items oi ON oi.order_id = o.id
GROUP BY c.id, c.name
ORDER BY total_revenue DESC;


-- 2. Top 5 produtos mais vendidos por quantidade
SELECT
    p.name AS product_name,
    SUM(oi.quantity) AS total_quantity
FROM products p
JOIN order_items oi ON oi.product_id = p.id
GROUP BY p.id, p.name
ORDER BY total_quantity DESC
LIMIT 5;


-- 3. Clientes que nunca fizeram pedido
SELECT
    c.name AS customer_name
FROM customers c
LEFT JOIN orders o ON o.customer_id = c.id
WHERE o.id IS NULL;


-- 4. Ticket medio por mes
SELECT
    strftime('%Y-%m', o.order_date) AS year_month,
    AVG(order_totals.order_total) AS average_order_value
FROM orders o
JOIN (
    SELECT order_id, SUM(quantity * unit_price) AS order_total
    FROM order_items
    GROUP BY order_id
) order_totals ON order_totals.order_id = o.id
GROUP BY year_month
ORDER BY year_month;


-- 5. Segundo maior pedido de cada cliente (window function)
WITH order_totals AS (
    SELECT
        o.id AS order_id,
        o.customer_id,
        SUM(oi.quantity * oi.unit_price) AS order_total
    FROM orders o
    JOIN order_items oi ON oi.order_id = o.id
    GROUP BY o.id, o.customer_id
),
ranked_orders AS (
    SELECT
        *,
        ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_total DESC) AS rank_position
    FROM order_totals
)
SELECT
    customer_id,
    order_id,
    order_total AS second_highest_order_value
FROM ranked_orders
WHERE rank_position = 2;


-- 6. Receita acumulada (running total) por dia
SELECT
    order_date,
    daily_total,
    SUM(daily_total) OVER (ORDER BY order_date) AS running_total
FROM (
    SELECT
        o.order_date AS order_date,
        SUM(oi.quantity * oi.unit_price) AS daily_total
    FROM orders o
    JOIN order_items oi ON oi.order_id = o.id
    GROUP BY o.order_date
) daily_revenue
ORDER BY order_date;


-- 7. Categoria com maior receita nos ultimos 90 dias (a partir da data mais recente na base)
WITH reference_date AS (
    SELECT MAX(order_date) AS max_date FROM orders
)
SELECT
    p.category AS category,
    SUM(oi.quantity * oi.unit_price) AS revenue
FROM order_items oi
JOIN orders o ON o.id = oi.order_id
JOIN products p ON p.id = oi.product_id
CROSS JOIN reference_date
WHERE o.order_date >= date(reference_date.max_date, '-90 days')
GROUP BY p.category
ORDER BY revenue DESC
LIMIT 1;
