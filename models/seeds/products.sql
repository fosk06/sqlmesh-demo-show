MODEL (
  name sqlmesh_jaffle_platform.products,
  tags ["dagster:group_name:staging", "staging"],
  kind SEED (
    path '../../seeds/products.csv'
  ),
  cron '@daily',
  columns (
    sku STRING,
    name STRING,
    type STRING,
    price INTEGER,
    description STRING
  ),
  grain (sku)
);
