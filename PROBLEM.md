# Relatório de Vendas — Desafio de SQL

Desafio autoral (não faz parte do repositório backend-br/desafios), no mesmo espírito de praticar SQL aplicado a um cenário realista de backend.

## Contexto

Você foi contratado por um e-commerce para gerar relatórios de vendas a partir do banco de dados existente. O schema tem 4 tabelas:

```
customers(id, name, email, signup_date)
products(id, name, category, price)
orders(id, customer_id, order_date)
order_items(id, order_id, product_id, quantity, unit_price)
```

`order_items.unit_price` guarda o preço no momento da compra (pode divergir do preço atual em `products`, já que preços mudam com o tempo).

## Requisitos

Escreva uma query SQL para cada um dos itens abaixo:

1. **Receita total por cliente**, ordenado do maior para o menor.
2. **Top 5 produtos mais vendidos** por quantidade total.
3. **Clientes que nunca fizeram nenhum pedido** (cadastrados mas sem compras).
4. **Ticket médio por mês** (valor médio de pedido, agrupado por ano-mês).
5. **Segundo maior pedido de cada cliente** (em valor), usando window function — não usar subquery correlacionada com `LIMIT`.
6. **Receita acumulada (running total) por dia**, ordenada cronologicamente.
7. **Categoria de produto com maior receita**, considerando apenas pedidos dos últimos 90 dias a partir da data mais recente na base.

## Requisitos técnicos

- Cada query deve rodar isoladamente (sem depender de queries anteriores).
- Pelo menos uma query deve usar window function (`ROW_NUMBER`, `RANK` ou `SUM() OVER`).
- Nomeie as colunas de saída de forma clara (`AS`).
- Considere que `order_items.unit_price * order_items.quantity` é o valor de cada item.

## Soluções

Este desafio foi resolvido e testado com dados de exemplo em SQLite (compatível com PostgreSQL/MySQL com ajustes mínimos de sintaxe de data). Veja `schema.sql` para o schema + dados de exemplo, e `solution.sql` para as queries comentadas.
