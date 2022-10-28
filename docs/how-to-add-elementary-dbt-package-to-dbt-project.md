# How to add Elementary dbt package to dbt project

https://github.com/elementary-data/elementary

Elementary dbt package will create tables along side of your dbt project and generate metadata and test results of the dbt project when runing `dbt` CLI.


## Step 1: Create `packages.yml` with elementary in the dbt project

https://docs.elementary-data.com/quickstart#1-add-elementary-to-packages-yml

The `packages.yml` should contain:
```
packages:
  - package: elementary-data/elementary
    version: 0.5.3
    ## Docs: https://docs.elementary-data.com
```    

```
elementary-data = {extras = ["bigquery"], version = "^0.5.3"}
```

## Step 2: Add elementary to `dbt_project.yml` in the dbt project

https://docs.elementary-data.com/quickstart#2-add-to-your-dbt-project-yml

The `dbt_project.yml` should contain:
```
models:
  ## elementary models will be created in the schema '<your_schema>_elementary'
  ## see docs: https://docs.elementary-data.com/
  elementary:
    +schema: "elementary"
```

## Step 3: Import the elementary package with dbt in Docker container

https://docs.elementary-data.com/quickstart#3-import-the-package

Run and entre Docker container:
```
make docker/run
```

In the container, run:
```
dbt deps
```

The output will look like:
```
# dbt deps
23:52:39  Running with dbt=1.3.0
23:52:39  Installing elementary-data/elementary
23:52:42    Installed from version 0.5.3
23:52:42    Up to date!
23:52:42  Installing dbt-labs/dbt_utils
23:52:44    Installed from version 0.9.2
23:52:44    Up to date!
```

## Step 4: Run dbt in Docker container to create the package models 

https://docs.elementary-data.com/quickstart#4-run-to-create-the-package-models

Run and entre Docker container:
```
make docker/run
```

In the container, run:
```
# to set GCP project details as environment variables
source ../exports.sh

dbt run --select elementary
```

The output will look like:
```
root@9e0a730db6f1:/workspaces/dbt_example# dbt run --select elementary
23:57:13  Running with dbt=1.3.0
23:57:13  Unable to do partial parsing because a project config has changed
23:57:16  Warning: the `current_timestamp` macro is deprecated and will be removed in a future version of the package, once equivalent functionality is implemented in dbt Core. The elementary.metrics_anomaly_score model triggered this warning.
23:57:17  Found 25 models, 4 tests, 0 snapshots, 0 analyses, 802 macros, 3 operations, 0 seed files, 0 sources, 0 exposures, 0 metrics
23:57:17
23:57:18
23:57:18  Running 1 on-run-start hook
23:57:18  1 of 1 START hook: elementary.on-run-start.0 ................................... [RUN]
23:57:18  1 of 1 OK hook: elementary.on-run-start.0 ...................................... [OK in 0.00s]
23:57:18
23:57:18  Concurrency: 8 threads (target='dev')
23:57:18
23:57:18  1 of 23 START sql incremental model dbt_example_elementary.data_monitoring_metrics  [RUN]
23:57:18  6 of 23 START sql table model dbt_example_elementary.dbt_snapshots ............. [RUN]
23:57:18  2 of 23 START sql table model dbt_example_elementary.dbt_exposures ............. [RUN]
23:57:18  3 of 23 START sql table model dbt_example_elementary.dbt_metrics ............... [RUN]
23:57:18  4 of 23 START sql table model dbt_example_elementary.dbt_models ................ [RUN]
23:57:18  5 of 23 START sql incremental model dbt_example_elementary.dbt_run_results ..... [RUN]
23:57:18  8 of 23 START sql table model dbt_example_elementary.dbt_sources ............... [RUN]
23:57:18  7 of 23 START sql incremental model dbt_example_elementary.dbt_source_freshness_results  [RUN]
23:57:24  7 of 23 OK created sql incremental model dbt_example_elementary.dbt_source_freshness_results  [MERGE (0.0 rows, 0 processed) in 5.63s]
23:57:24  9 of 23 START sql table model dbt_example_elementary.dbt_tests ................. [RUN]
23:57:24  3 of 23 OK created sql table model dbt_example_elementary.dbt_metrics .......... [CREATE TABLE (0.0 rows, 0 processed) in 5.69s]
23:57:24  8 of 23 OK created sql table model dbt_example_elementary.dbt_sources .......... [CREATE TABLE (0.0 rows, 0 processed) in 5.70s]
23:57:24  10 of 23 START sql incremental model dbt_example_elementary.elementary_test_results  [RUN]
23:57:24  6 of 23 OK created sql table model dbt_example_elementary.dbt_snapshots ........ [CREATE TABLE (0.0 rows, 0 processed) in 5.74s]
23:57:24  11 of 23 START sql view model dbt_example_elementary.filtered_information_schema_columns  [RUN]
23:57:24  12 of 23 START sql view model dbt_example_elementary.filtered_information_schema_tables  [RUN]
23:57:24  2 of 23 OK created sql table model dbt_example_elementary.dbt_exposures ........ [CREATE TABLE (0.0 rows, 0 processed) in 5.84s]
23:57:24  13 of 23 START sql incremental model dbt_example_elementary.schema_columns_snapshot  [RUN]
23:57:24  5 of 23 OK created sql incremental model dbt_example_elementary.dbt_run_results  [MERGE (0.0 rows, 40.6 KB processed) in 5.88s]
23:57:24  1 of 23 OK created sql incremental model dbt_example_elementary.data_monitoring_metrics  [MERGE (0.0 rows, 0 processed) in 5.90s]
23:57:24  14 of 23 START sql view model dbt_example_elementary.alerts_dbt_source_freshness  [RUN]
23:57:24  15 of 23 START sql view model dbt_example_elementary.snapshot_run_results ...... [RUN]
23:57:25  11 of 23 OK created sql view model dbt_example_elementary.filtered_information_schema_columns  [CREATE VIEW (0 processed) in 0.93s]
23:57:25  16 of 23 START sql view model dbt_example_elementary.metrics_anomaly_score ..... [RUN]
23:57:25  Warning: the `current_timestamp` macro is deprecated and will be removed in a future version of the package, once equivalent functionality is implemented in dbt Core. The elementary.metrics_anomaly_score model triggered this warning.
23:57:25  12 of 23 OK created sql view model dbt_example_elementary.filtered_information_schema_tables  [CREATE VIEW (0 processed) in 1.11s]
23:57:25  17 of 23 START sql view model dbt_example_elementary.monitors_runs ............. [RUN]
23:57:25  14 of 23 OK created sql view model dbt_example_elementary.alerts_dbt_source_freshness  [CREATE VIEW (0 processed) in 1.12s]
23:57:25  15 of 23 OK created sql view model dbt_example_elementary.snapshot_run_results . [CREATE VIEW (0 processed) in 1.17s]
23:57:26  16 of 23 OK created sql view model dbt_example_elementary.metrics_anomaly_score  [CREATE VIEW (0 processed) in 0.93s]
23:57:26  18 of 23 START sql view model dbt_example_elementary.anomaly_threshold_sensitivity  [RUN]
23:57:26  17 of 23 OK created sql view model dbt_example_elementary.monitors_runs ........ [CREATE VIEW (0 processed) in 1.10s]
23:57:27  4 of 23 OK created sql table model dbt_example_elementary.dbt_models ........... [CREATE TABLE (0.0 rows, 0 processed) in 8.56s]
23:57:27  19 of 23 START sql view model dbt_example_elementary.model_run_results ......... [RUN]
23:57:27  18 of 23 OK created sql view model dbt_example_elementary.anomaly_threshold_sensitivity  [CREATE VIEW (0 processed) in 1.11s]
23:57:27  13 of 23 OK created sql incremental model dbt_example_elementary.schema_columns_snapshot  [MERGE (0.0 rows, 0 processed) in 2.85s]
23:57:28  19 of 23 OK created sql view model dbt_example_elementary.model_run_results .... [CREATE VIEW (0 processed) in 1.12s]
23:57:28  20 of 23 START sql view model dbt_example_elementary.alerts_dbt_models ......... [RUN]
23:57:29  20 of 23 OK created sql view model dbt_example_elementary.alerts_dbt_models .... [CREATE VIEW (0 processed) in 1.14s]
23:57:29  10 of 23 OK created sql incremental model dbt_example_elementary.elementary_test_results  [MERGE (0.0 rows, 2.7 KB processed) in 5.32s]
23:57:29  21 of 23 START sql view model dbt_example_elementary.alerts_anomaly_detection .. [RUN]
23:57:29  22 of 23 START sql view model dbt_example_elementary.alerts_dbt_tests .......... [RUN]
23:57:29  23 of 23 START sql view model dbt_example_elementary.alerts_schema_changes ..... [RUN]
23:57:30  22 of 23 OK created sql view model dbt_example_elementary.alerts_dbt_tests ..... [CREATE VIEW (0 processed) in 0.83s]
23:57:30  21 of 23 OK created sql view model dbt_example_elementary.alerts_anomaly_detection  [CREATE VIEW (0 processed) in 0.84s]
23:57:30  23 of 23 OK created sql view model dbt_example_elementary.alerts_schema_changes  [CREATE VIEW (0 processed) in 1.01s]
23:57:31  9 of 23 OK created sql table model dbt_example_elementary.dbt_tests ............ [CREATE TABLE (0.0 rows, 0 processed) in 7.55s]
23:57:31
23:57:31  Running 2 on-run-end hooks
23:57:31  1 of 2 START hook: elementary.on-run-end.0 ..................................... [RUN]
23:57:31  1 of 2 OK hook: elementary.on-run-end.0 ........................................ [OK in 0.00s]
23:57:37  Elementary: Uploaded run results successfully.
23:57:37  2 of 2 START hook: elementary.on-run-end.1 ..................................... [RUN]
23:57:37  2 of 2 OK hook: elementary.on-run-end.1 ........................................ [OK in 0.00s]
23:57:37
23:57:37
23:57:37  Finished running 5 incremental models, 6 table models, 12 view models, 3 hooks in 0 hours 0 minutes and 20.00 seconds (20.00s).
23:57:37
23:57:37  Completed successfully
23:57:37
23:57:37  Done. PASS=23 WARN=0 ERROR=0 SKIP=0 TOTAL=23
```

This creates `dbt_example_elementary` dataset in the GCP project which has below tables:

```
bq ls dbt_example_elementary
                tableId                 Type    Labels   Time Partitioning   Clustered Fields
 ------------------------------------- ------- -------- ------------------- ------------------
  alerts_anomaly_detection              VIEW
  alerts_dbt_models                     VIEW
  alerts_dbt_source_freshness           VIEW
  alerts_dbt_tests                      VIEW
  alerts_schema_changes                 VIEW
  anomaly_threshold_sensitivity         VIEW
  data_monitoring_metrics               TABLE
  dbt_exposures                         TABLE
  dbt_metrics                           TABLE
  dbt_models                            TABLE
  dbt_run_results                       TABLE
  dbt_snapshots                         TABLE
  dbt_source_freshness_results          TABLE
  dbt_sources                           TABLE
  dbt_tests                             TABLE
  elementary_test_results               TABLE
  filtered_information_schema_columns   VIEW
  filtered_information_schema_tables    VIEW
  metrics_anomaly_score                 VIEW
  model_run_results                     VIEW
  monitors_runs                         VIEW
  schema_columns_snapshot               TABLE
  snapshot_run_results                  VIEW

```

The tables seem empty at this point:
```
bq query 'SELECT COUNT(1) FROM dbt_example_elementary.dbt_metrics'
+-----+
| f0_ |
+-----+
|   0 |
+-----+
```

## Step 5: Run tests and check test results generated by elementary

https://docs.elementary-data.com/quickstart#5-run-tests

In the container, run:
```
dbt test
```

`dbt_example_elementary.elementary_test_results` is populated:
```
 bq query 'SELECT schema_name, table_name, test_name, test_results_description, status, failures FROM dbt_example_elementary.elementary_test_results'
+-------------+---------------------+-----------+------------------------------------------+--------+----------+
| schema_name |     table_name      | test_name |         test_results_description         | status | failures |
+-------------+---------------------+-----------+------------------------------------------+--------+----------+
| dbt_example | my_first_dbt_model  | not_null  | Got 1 result, configured to fail if != 0 | fail   |        1 |
| dbt_example | my_first_dbt_model  | unique    | NULL                                     | pass   |        0 |
| dbt_example | my_second_dbt_model | not_null  | NULL                                     | pass   |        0 |
| dbt_example | my_second_dbt_model | unique    | NULL                                     | pass   |        0 |
+-------------+---------------------+-----------+------------------------------------------+--------+----------+
```

`dbt_example_elementary.elementary_test_results`'s schema is:
```
bq show --schema --format=prettyjson dbt_example_elementary.elementary_test_results
[
  {
    "name": "id",
    "type": "STRING"
  },
  {
    "name": "data_issue_id",
    "type": "STRING"
  },
  {
    "name": "test_execution_id",
    "type": "STRING"
  },
  {
    "name": "test_unique_id",
    "type": "STRING"
  },
  {
    "name": "model_unique_id",
    "type": "STRING"
  },
  {
    "name": "detected_at",
    "type": "TIMESTAMP"
  },
  {
    "name": "database_name",
    "type": "STRING"
  },
  {
    "name": "schema_name",
    "type": "STRING"
  },
  {
    "name": "table_name",
    "type": "STRING"
  },
  {
    "name": "column_name",
    "type": "STRING"
  },
  {
    "name": "test_type",
    "type": "STRING"
  },
  {
    "name": "test_sub_type",
    "type": "STRING"
  },
  {
    "name": "test_results_description",
    "type": "STRING"
  },
  {
    "name": "owners",
    "type": "STRING"
  },
  {
    "name": "tags",
    "type": "STRING"
  },
  {
    "name": "test_results_query",
    "type": "STRING"
  },
  {
    "name": "other",
    "type": "STRING"
  },
  {
    "name": "test_name",
    "type": "STRING"
  },
  {
    "name": "test_params",
    "type": "STRING"
  },
  {
    "name": "severity",
    "type": "STRING"
  },
  {
    "name": "status",
    "type": "STRING"
  },
  {
    "name": "failures",
    "type": "INTEGER"
  }
]
```


