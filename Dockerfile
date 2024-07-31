

ARG PYTHON_VERSION=3.12.4


FROM python:${PYTHON_VERSION}-alpine AS base
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


FROM base AS test

RUN  apk add --no-cache  gcc python3-dev musl-dev linux-headers bash curl

# Crear y activar un entorno virtual
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"


# Copiar el archivo de requisitos
COPY requirements.txt requirements.txt

# Instalar las dependencias del archivo de requisitos
RUN pip3 install --no-cache-dir -r requirements.txt
RUN pip3 install --no-cache-dir pytest==8.3.2
COPY . .

RUN chown -R appuser:appuser /app
# Switch to the non-privileged user to run the application.
USER appuser
# Expose the port that the application listens on.
EXPOSE 8000

# Run the application.
# CMD ["gunicorn", "--bind", "0.0.0.0:8000",  "--timeout", "120", "app:app"]

FROM base AS final


RUN  apk add --no-cache  gcc python3-dev musl-dev linux-headers


# Copiar el archivo de requisitos
COPY requirements.txt requirements.txt

# Instalar las dependencias del archivo de requisitos
RUN pip3 install --no-cache-dir -r requirements.txt
COPY . .

USER appuser
# Expose the port that the application listens on.
EXPOSE 8000

# Run the application.
CMD ["gunicorn", "--bind", "0.0.0.0:8000",  "--timeout", "120", "app:app"]