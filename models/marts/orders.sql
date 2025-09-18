MODEL (
  name sqlmesh_jaffle_platform.orders_mart,
  kind FULL,
  cron '*/5 * * * *',
  grain order_id,
  tags ["dagster:group_name:datamarts", "datamarts"],
  partitioned_by = ["order_date"],
  audits(
    number_of_rows(threshold := 10),
    not_null(columns := (order_id, customer_id, store_id, order_date, order_total, status)),
    unique_values(columns := (order_id))
  ),

  column_descriptions (
    order_id = 'Unique identifier for each order',
    customer_id = 'Identifier linking to the customer who placed the order',
    order_date = 'Date when the order was placed',
    store_id = 'Identifier of the store where the order was placed',
    subtotal = 'Order subtotal before tax and discounts',
    tax_paid = 'Tax amount paid on the order',
    order_total = 'Total order amount including tax',
    status = 'Order status (completed, pending, cancelled)',
    count_order_items = 'Number of items in the order',
    is_multi_item_order = 'Whether the order contains multiple items'
  )
);

with orders as (
    select * from sqlmesh_jaffle_platform.stg_orders
),
order_items as (
    select * from sqlmesh_jaffle_platform.stg_order_items
),
order_items_summary as (
    select
        order_id,
        count(order_item_id) as count_order_items
    from order_items
    group by 1
),
compute_booleans as (
    select
        orders.*,
        coalesce(order_items_summary.count_order_items, 0) as count_order_items,
        coalesce(order_items_summary.count_order_items, 0) > 1 as is_multi_item_order
    from orders
    left join order_items_summary
        on orders.order_id = order_items_summary.order_id
)

select * from compute_booleans