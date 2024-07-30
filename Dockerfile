

ARG PYTHON_VERSION=3.12.4


FROM python:${PYTHON_VERSION}-alpine as base
# Prevents Python from writing pyc files.
ENV PYTHONDONTWRITEBYTECODE=1

# Keeps Python from buffering stdout and stderr to avoid situations where
# the application crashes without emitting any logs due to buffering.
ENV PYTHONUNBUFFERED=1

WORKDIR /app

# Create a non-privileged user that the app will run under.
# See https://docs.docker.com/go/dockerfile-user-best-practices/
ARG UID=10001
RUN adduser \
    --disabled-password \
    --gecos "" \
    --home "/nonexistent" \
    --shell "/sbin/nologin" \
    --no-create-home \
    --uid "${UID}" \
    appuser



RUN  apk add --no-cache  gcc python3-dev musl-dev linux-headers bash

RUN  pip install --no-binary :all: psutil

COPY requirements.txt requirements.txt

RUN python -m pip install --no-cache-dir -r requirements.txt

COPY . .

RUN chown -R appuser:appuser /app
# Switch to the non-privileged user to run the application.
USER appuser
# Expose the port that the application listens on.
EXPOSE 8000

# Run the application.
CMD ["gunicorn", "--bind", "0.0.0.0:8000",  "--timeout", "120", "app:app"]
