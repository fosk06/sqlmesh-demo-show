FROM python:3.12-slim-bookworm
RUN apt-get update && apt-get upgrade -y && apt-get install vim postgresql-client libpq-dev build-essential gcc -y && apt-get clean && rm -rf /var/lib/apt/lists/*
COPY --from=docker.io/astral/uv:0.8.14 /uv /uvx /bin/

WORKDIR /app

COPY pyproject.toml .
COPY . .

RUN uv sync --all-extras