MODEL (
  name sqlmesh_jaffle_platform.customers,
  tags ["dagster:group_name:staging", "staging"],
  kind SEED (
    path '../../seeds/customers.csv'
  ),
  cron '@daily',
  columns (
    id STRING,
    name STRING
  ),
  grain (id)
);
