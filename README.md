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

## How the dbt project was created
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

## How to run dbt commands
1. Go to `dbt_example` dbt project directry
```
cd dbt_example/
```
2. Set GCP account and project ID in exports.sh
```
source exports.sh
```
3. Setup gcloud config and authenticate to Google Cloud API for bq CLI
```
make gcloud/setup
```
4. Run dbt commands
```
# tests fail if dbt_example dataset does not exist
dbt test

# to create dbt_example dataset with models
dbt run

# tests pass except one
dbt test
```
5. Run bq command
```
# to see dbt_example dataset created
bq ls
bq ls dbt_example
```
