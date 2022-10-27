# Experimental: Out-of-box dev environment for dbt with VSCode

## Pre-requisites
- VSCode with below extensions
  - Remote SSH
  - Remote Development
  - Makefile tools
- Docker
- GCP account
- GCP project ID for BigQuery

## How to run the development container in VSCode
1. Clone and open the repo in VSCode
2. Remote Explore -> Reopen in Container
3. Open Terminal to be in the container

## How to run dbt commands in container (terminal in VSCode)
1. Configure GCP account and project ID in exports.sh
```
source exports.sh
```
2. Go to `dbt_example` dbt project directry
```
cd dbt_example/
```
3. Run dbt commands
```
# tests fail if dbt_example dataset does not exist
dbt test

# to create dbt_example dataset with models
dbt run

# tests pass except one
dbt test
```

## How to run bq CLI in container (terminal in VSCode)

1. In the top directory, setup gcloud config for the GCP project and authenticate to Google Cloud API for bq CLI
```
make gcloud/setup
```

2. Run bq command
```
# to see dbt_example dataset created
bq ls

# to see the models created
bq ls dbt_example

# to query a table
bq query 'SELECT * FROM dbt_example.my_first_dbt_model'
```

## How to run the same Docker container without VSCode

1. Build Docker image
```
make docker/build
```

2. Run Docker container
```
make docker/run
```


## Appendix
### How the dbt project was created
1. Create Dockerfile based on python image with dbt and gcloud
  - NOTE: this is to have a clean local dev environment without having to install tools individually
2. Build the Docker image, run it and go into the container via VSCode Terminal
3. Based on https://docs.getdbt.com/docs/building-a-dbt-project/projects#getting-started, in the container, run:
```
dbt init dbt_example
```
  - Options specified during `init` which were saved in `profiles.yml`:
    - BigQuery
    - oauth (for ease of initial setup; TODO: change to service_account)
    - `dbt_example` as dataset
    - 8 hreads
    - EU as data location
