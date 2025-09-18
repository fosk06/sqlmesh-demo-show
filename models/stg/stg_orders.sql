MODEL (
  name sqlmesh_jaffle_platform.stg_orders,
  kind FULL,
  cron '*/5 * * * *',
  grain order_id,
  tags ["dagster:group_name:staging", "staging"],
  audits(
    number_of_rows(threshold := 10),
    not_null(columns := (order_id, customer_id, store_id))
  )
);


with source as (

    select * from sqlmesh_jaffle_platform.orders

),

renamed as (

    select
        id as order_id,
        customer as customer_id,
        ordered_at as order_date,
        store_id,
        subtotal,
        tax_paid,
        order_total,
        'completed' as status  -- Assuming all orders are completed since we don't have status in raw data

    from source

)

select * from renamed