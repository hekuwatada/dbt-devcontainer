# How to add Elementary CLI

Elementary CLI reads from the metadata and test results data from tables created by Elementary dbt package, and is used to generate the UI and alerts.

Ref: https://docs.elementary-data.com/quickstart-cli

## Pre-requisite 1: Entre Docker container

Without VSCode:
```
make docker/run
```

OR in VSCode, rebuild the container.

## Pre-requisite 2: Edit `exports.sh` with your GCP details and export them as environment variables
```
source exports.sh
```

## Step 1: Configure Elementary profile in the container

Ref: https://docs.elementary-data.com/quickstart-cli

(1) Run below:
```
dbt run-operation elementary.generate_elementary_cli_profile
```

Output will look like:
```
# dbt run-operation elementary.generate_elementary_cli_profile
09:33:06  Running with dbt=1.3.0
09:33:07

elementary:
  outputs:
    default:
      type: bigquery
      method: <AUTH_METHOD>
      project: dev-bq-322916
      dataset: dbt_example_elementary
      threads: 8
```
(2) Copy-paste the output and add it to the `profiles.yml`

## Step 2: Install Elementary CLI in the container

(1) Run below:
```
poetry add elementary-data[bigquery]
```

(2) Run Elementary CLI to confirm installation:
```
edr --help
```

