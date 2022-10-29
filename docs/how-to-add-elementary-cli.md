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

## Step 3: Visualise all dbt test results and runs in a report 

Ref: https://docs.elementary-data.com/quickstart/generate-report-ui

(1) Run below to access the BigQuery (data warehouse) wth the connection profile specified with `-p`, read from the Elementary tables and generate a HTML report: 
```
edr monitor report -p .
```

This will create files like below:
```
edr.log
elementary_-_2022-10-29T09-54-56.838338+00-00_utc.html
elementary_output.json
```

## Step 4: Open the generated report in HTML

Open `elementary_-_*.html` in a Browser.



## Appendix

### How to use Elementary CLI for the second time

#### Step 1: Build Docker image
```
make docker/build
```

### Step 2: Entre Docker container where edr is available

(1) Run below to entre Docker container:
```
make docker/run
```

(2) Check Elementary CLI is available in the container:
```
edr --help
```

### Step 3: Set GCP project details as environment variables in the container

```
source ../exports.sh
```

### Step 4: Run edr with dbt to test GCP project connection

```
edr monitor report -p .
```
