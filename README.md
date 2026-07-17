# Relatório de Vendas — Desafio de SQL

![SQL](https://img.shields.io/badge/SQL-SQLite%20%7C%20PostgreSQL-4479A1?logo=postgresql&logoColor=white)

Desafio autoral de SQL aplicado a um cenário de e-commerce: dado um schema com clientes, produtos, pedidos e itens de pedido, escrever queries que respondam perguntas reais de negócio (receita, ranking, ticket médio, segundo maior pedido por cliente, receita acumulada e receita por categoria em uma janela de tempo).

## Schema

```
customers(id, name, email, signup_date)
products(id, name, category, price)
orders(id, customer_id, order_date)
order_items(id, order_id, product_id, quantity, unit_price)
```

`order_items.unit_price` guarda o preço no momento da compra, já que preços de produtos mudam com o tempo — os dados de exemplo incluem casos assim de propósito.

## Requisitos resolvidos

1. Receita total por cliente
2. Top 5 produtos mais vendidos por quantidade
3. Clientes que nunca fizeram pedido (`LEFT JOIN` + `IS NULL`)
4. Ticket médio por mês
5. Segundo maior pedido de cada cliente, usando `ROW_NUMBER() OVER (PARTITION BY ...)`
6. Receita acumulada (running total) por dia, usando `SUM() OVER (ORDER BY ...)`
7. Categoria com maior receita nos últimos 90 dias a partir da data mais recente na base

## Como rodar

```bash
sqlite3 vendas.db < schema.sql
sqlite3 vendas.db < solution.sql
```

Ou via Python, sem precisar instalar o CLI do SQLite:

```python
import sqlite3

conn = sqlite3.connect("vendas.db")
cur = conn.cursor()
cur.executescript(open("schema.sql").read())
cur.executescript(open("solution.sql").read())
```

Todas as queries foram testadas com os dados de exemplo e os resultados conferidos manualmente (ex: receita da Carla Souza = R$ 3.190,00, verificado somando os 3 pedidos dela linha por linha).

## Portabilidade

As queries usam `strftime()` e `date()`, específicas do SQLite. Pra rodar em PostgreSQL, troca por:
- `strftime('%Y-%m', order_date)` → `TO_CHAR(order_date, 'YYYY-MM')`
- `date(max_date, '-90 days')` → `max_date - INTERVAL '90 days'`

Em MySQL:
- `strftime('%Y-%m', order_date)` → `DATE_FORMAT(order_date, '%Y-%m')`
- `date(max_date, '-90 days')` → `DATE_SUB(max_date, INTERVAL 90 DAY)`

As window functions (`ROW_NUMBER`, `SUM() OVER`) são padrão ANSI SQL e funcionam sem alterações no PostgreSQL e MySQL 8+.

---

© 2026 Gabriel Teramae Chan
