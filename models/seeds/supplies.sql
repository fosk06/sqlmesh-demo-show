MODEL (
  name sqlmesh_jaffle_platform.supplies,
  tags ["dagster:group_name:staging", "staging"],
  kind SEED (
    path '../../seeds/supplies.csv'
  ),
  cron '@daily',
  columns (
    id STRING,
    name STRING,
    cost INTEGER,
    perishable BOOLEAN,
    sku STRING
  ),
  grain (id)
);
