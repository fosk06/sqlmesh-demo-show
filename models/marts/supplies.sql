MODEL (
  name sqlmesh_jaffle_platform.supplies_mart,
  kind FULL,
  tags ["dagster:group_name:datamarts", "datamarts"],
  cron '*/5 * * * *',
  grain (id, sku),
);

select * from sqlmesh_jaffle_platform.stg_supplies 