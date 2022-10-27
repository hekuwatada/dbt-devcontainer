# How to run dbt in Docker container

## Pre-requisites
- GCP project
- GCP project account email
- GCP project config

## Step 1: Set GCP project details as environment variables

```
export GCP_DEV_PROJECT=<GCP project ID>
export GCP_ACCOUNT=<GCP account email>
export GCP_CONFIG_NAME=<GCP project config name>
```

## Step 2: Activate the GCP project

```
make gcloud/activate
```

## Step 3: Build Docker image

```
make docker/build
```

## Step 4: Entre the Docker container

```
make docker/run
```

## Step 5: Run dbt in the Docker container

Run `dbt --version`:
```
make docker/dbt ARGS='--version'
```

Run `dbt list` (requires accessing GCP project):
```
make docker/dbt ARGS='list'
```

