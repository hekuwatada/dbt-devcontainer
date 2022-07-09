# Container for development using VSCode Dev Container in VSCode
FROM python:3.8.5

# Update and install system packages
RUN apt-get update -y && \
  apt-get install --no-install-recommends -y -q \
  git libpq-dev python-dev && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install DBT
RUN pip install -U pip
RUN pip install dbt-bigquery

# Set DBT profiles directory for profiles.yml
ENV DBT_PROFILES_DIR=./
# ENV GOOGLE_APPLICATION_CREDENTIALS=''