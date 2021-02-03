FROM python:3
ENV PYTHONUNBUFFERED=1 \
 PIP_DISABLE_PIP_VERSION_CHECK=on \
 PATH="/root/.poetry/bin:$PATH" \
 POETRY_VERSION=1.1.4

RUN apt-get update && apt-get install -f --force-yes -y curl gnupg \
	&& apt-get update \
	&& mkdir -p /usr/share/man/man1 \
	&& mkdir -p /usr/share/man/man7 \
	&& apt-get install -f --force-yes -y ca-certificates vim nano cron jq python-dev postgresql-client wget git gcc libpq-dev \
	&& rm -rf /var/lib/apt/lists/*

RUN curl -sSL "https://raw.githubusercontent.com/sdispater/poetry/master/get-poetry.py" | python
 
COPY ./pyproject.toml pyproject.toml
COPY ./poetry.lock poetry.lock

RUN poetry config virtualenvs.create false
RUN poetry install $(test "$DEV_IMAGE" = false && echo "--no-dev") --no-interaction --no-ansi

WORKDIR /app

COPY . /app

EXPOSE 80

ENTRYPOINT ["/app/run.sh"]
