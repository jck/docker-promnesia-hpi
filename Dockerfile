# syntax = docker/dockerfile:experimental
FROM python:3.10

RUN python -m venv /app/venv 
ENV PATH="/app/venv/bin:$PATH"

# this ensures that there are no pyc files in ~/.config/{promnesia,my}
ENV PYTHONPYCACHEPREFIX=/.pycache

ENV POETRY_HOME="/opt/poetry" \
    POETRY_VIRTUALENVS_IN_PROJECT=true
ENV PATH="$POETRY_HOME/bin:$PATH"
RUN curl -sSL https://raw.githubusercontent.com/sdispater/poetry/master/get-poetry.py | python

WORKDIR /app
COPY pyproject.toml poetry.lock ./
RUN --mount=type=cache,id=poetry,target=/root/.cache/pypoetry --mount=type=cache,target=/root/.cache/pip \
  . /app/venv/bin/activate && poetry install --no-root
