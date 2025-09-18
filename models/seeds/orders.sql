MODEL (
  name sqlmesh_jaffle_platform.orders,
  tags ["dagster:group_name:staging", "staging"],
  kind SEED (
    path '../../seeds/orders.csv'
  ),
  cron '@daily',
  columns (
    id STRING,
    customer STRING,
    ordered_at TIMESTAMP,
    store_id STRING,
    subtotal INTEGER,
    tax_paid INTEGER,
    order_total INTEGER
  ),
  grain (id)
);
