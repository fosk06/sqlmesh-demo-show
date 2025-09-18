MODEL (
  name sqlmesh_jaffle_platform.items,
  tags ["dagster:group_name:staging", "staging"],
  kind SEED (
    path '../../seeds/items.csv'
  ),
  cron '@daily',
  columns (
    id STRING,
    order_id STRING,
    sku STRING
  ),
  grain (id)
);
