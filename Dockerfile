# syntax = docker/dockerfile:experimental
FROM ghcr.io/jck/python:latest

ENV POETRY_VIRTUALENVS_IN_PROJECT=true
ENV PATH="/app/.venv/bin:$PATH"

WORKDIR /app
COPY pyproject.toml poetry.lock ./
RUN --mount=type=cache,target=/root/.cache/pypoetry --mount=type=cache,target=/root/.cache/pip \
  poetry install --no-root
