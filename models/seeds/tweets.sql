MODEL (
  name sqlmesh_jaffle_platform.tweets,
  tags ["dagster:group_name:staging", "staging"],
  kind SEED (
    path '../../seeds/tweets.csv'
  ),
  cron '@daily',
  columns (
    id STRING,
    user_id STRING,
    tweeted_at TIMESTAMP,
    content STRING
  ),
  grain (id)
);
