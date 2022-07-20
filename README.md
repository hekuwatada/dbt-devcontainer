# Experimental: Out-of-box dev environment for dbt with VSCode

## Pre-requisites
- VSCode with below extensions
  - Remote SSH
  - Remote Development
- Docker

## How to run the development container in VSCode
- Clone and open the repo in VSCode
- Remote Explore -> Reopen in Container
- Open Terminal to be in the container

## How the dbt project was created
- Create Dockerfile based on python image with dbt and gcloud
  - NOTE: this is to have a clean local dev environment without having to install tools individually
- Build the Docker image, run it and go into the container via VSCode Terminal
- Based on https://docs.getdbt.com/docs/building-a-dbt-project/projects#getting-started, in the container, run:
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
```
cd dbt_example/
dbt compile
```
