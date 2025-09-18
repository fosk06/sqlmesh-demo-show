MODEL (
  name sqlmesh_jaffle_platform.stores,
  tags ["dagster:group_name:staging", "staging"],
  kind SEED (
    path '../../seeds/stores.csv'
  ),
  cron '@daily',
  columns (
    id STRING,
    name STRING,
    opened_at TIMESTAMP,
    tax_rate DOUBLE
  ),
  grain (id)
);
