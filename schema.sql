-- Schema

CREATE TABLE customers (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    signup_date DATE NOT NULL
);

CREATE TABLE products (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    category TEXT NOT NULL,
    price NUMERIC(10, 2) NOT NULL
);

CREATE TABLE orders (
    id INTEGER PRIMARY KEY,
    customer_id INTEGER NOT NULL REFERENCES customers(id),
    order_date DATE NOT NULL
);

CREATE TABLE order_items (
    id INTEGER PRIMARY KEY,
    order_id INTEGER NOT NULL REFERENCES orders(id),
    product_id INTEGER NOT NULL REFERENCES products(id),
    quantity INTEGER NOT NULL,
    unit_price NUMERIC(10, 2) NOT NULL
);

-- Sample data

INSERT INTO customers (id, name, email, signup_date) VALUES
(1, 'Ana Silva', 'ana.silva@email.com', '2025-01-10'),
(2, 'Bruno Costa', 'bruno.costa@email.com', '2025-01-15'),
(3, 'Carla Souza', 'carla.souza@email.com', '2025-02-01'),
(4, 'Diego Lima', 'diego.lima@email.com', '2025-02-20'),
(5, 'Elaine Rocha', 'elaine.rocha@email.com', '2025-03-05');
-- Elaine (id=5) nunca fez pedido

INSERT INTO products (id, name, category, price) VALUES
(1, 'Teclado Mecanico', 'Periféricos', 350.00),
(2, 'Mouse Gamer', 'Periféricos', 180.00),
(3, 'Monitor 27"', 'Monitores', 1200.00),
(4, 'Headset', 'Periféricos', 250.00),
(5, 'Webcam HD', 'Acessórios', 220.00),
(6, 'Cadeira Gamer', 'Móveis', 1500.00),
(7, 'Mousepad XL', 'Acessórios', 60.00);

INSERT INTO orders (id, customer_id, order_date) VALUES
(1, 1, '2025-04-01'),
(2, 1, '2025-05-10'),
(3, 2, '2025-04-05'),
(4, 3, '2025-04-20'),
(5, 3, '2025-05-01'),
(6, 3, '2025-06-15'),
(7, 4, '2025-06-20'),
(8, 1, '2025-06-25'),
(9, 2, '2025-05-30');

INSERT INTO order_items (id, order_id, product_id, quantity, unit_price) VALUES
(1, 1, 1, 1, 350.00),
(2, 1, 2, 1, 180.00),
(3, 2, 3, 1, 1200.00),
(4, 3, 4, 2, 250.00),
(5, 4, 6, 1, 1500.00),
(6, 5, 2, 2, 180.00),
(7, 5, 7, 3, 60.00),
(8, 6, 3, 1, 1150.00),  -- preco diferente do atual (produto ficou mais caro depois)
(9, 7, 5, 1, 220.00),
(10, 7, 7, 1, 60.00),
(11, 8, 1, 2, 340.00),  -- preco tambem diferente do atual
(12, 9, 4, 1, 250.00);
