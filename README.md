# SQL Vendas — relatórios sobre dados de exemplo

![SQLite](https://img.shields.io/badge/SQLite-003B57?logo=sqlite&logoColor=white)

Quatro tabelas de um e-commerce fictício e sete consultas: receita por cliente, top 5 produtos por quantidade, clientes sem pedido, ticket médio por mês, segundo maior pedido por cliente, receita acumulada por dia e categoria de maior receita nos 90 dias anteriores à data máxima da base. O preço usado é `order_items.unit_price`, não o preço atual de `products`. Os `INSERT` de exemplo têm dois itens com preço diferente do cadastro. Não há dado real de venda.

## Stack

- SQL de SQLite em `schema.sql` e `solution.sql`
- `strftime('%Y-%m', ...)` e `date(max_date, '-90 days')` são do SQLite
- `ROW_NUMBER` e `SUM() OVER` são window functions; o dialeto de data é que não viaja sozinho

## Estrutura

```
.
├── PROBLEM.md      # enunciado das sete perguntas
├── schema.sql      # tabelas e INSERT de exemplo
└── solution.sql    # as sete consultas, comentadas
```

Tabelas: `customers` (id, name, email, signup_date), `products` (id, name, category, price), `orders` (id, customer_id, order_date), `order_items` (id, order_id, product_id, quantity, unit_price). Cinco clientes, sete produtos, nove pedidos, doze itens. Elaine Rocha (id 5) não tem pedido.

## Como rodar

```bash
git clone https://github.com/gabrielteramae/sql-vendas-teste.git
cd sql-vendas-teste
sqlite3 vendas.db < schema.sql
sqlite3 vendas.db < solution.sql
```

`schema.sql` faz `CREATE TABLE` sem `IF NOT EXISTS`. Rodar de novo no mesmo `vendas.db` falha. Apague o arquivo ou use outro nome. As consultas não dependem uma da outra: cada bloco em `solution.sql` executa sozinho.

Em PostgreSQL, `strftime('%Y-%m', order_date)` vira `TO_CHAR(order_date, 'YYYY-MM')` e `date(max_date, '-90 days')` vira `max_date - INTERVAL '90 days'`. Em MySQL, `DATE_FORMAT(order_date, '%Y-%m')` e `DATE_SUB(max_date, INTERVAL 90 DAY)`.

## Testes realizados

Não há suíte automatizada. A conferência é manual, em cima dos `INSERT` de `schema.sql`.

---

© 2026 Gabriel Teramae Chan
