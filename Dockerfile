# Container for development using VSCode Dev Container in VSCode
FROM python:3.8.5

# Update and install system packages
RUN apt-get update -y \
  && apt-get install --no-install-recommends -y -q \
  git \
  libpq-dev \
  python-dev \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install gcloud
RUN mkdir -p /usr/local/gcloud \
  && curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-392.0.0-linux-x86_64.tar.gz \
  && tar -C /usr/local/gcloud -xf google-cloud-cli-392.0.0-linux-x86_64.tar.gz \
  && /usr/local/gcloud/google-cloud-sdk/install.sh --quiet \
  && rm google-cloud-cli-392.0.0-linux-x86_64.tar.gz
ENV PATH=$PATH:/usr/local/gcloud/google-cloud-sdk/bin/

# Install Poetry
RUN curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/install-poetry.py | python -

# TODO: use non-root user
ENV PATH=$PATH:/root/.local/bin

# Install Python dependencies
COPY poetry.lock .
COPY pyproject.toml .
ENV POETRY_VIRTUALENVS_CREATE=false
RUN poetry install

# Set DBT profiles directory for profiles.yml
ENV DBT_PROFILES_DIR=./
