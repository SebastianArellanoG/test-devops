# Prueba técnica -DevOps Engineer Junior

## Flask Metrics App

Esta es una aplicación simple de Flask que expone un endpoint `/metrics` para obtener métricas del sistema como uso de CPU y memoria.

## Requisitos

- Docker

## Instalación

Clona este repositorio:

```bash
git clone git@github.com:SebastianArellanoG/test-devops-junior.git
```

```bash
cd test-devops
```

## Deploy con Dockerfile

1. Construye y despliega la aplicación utilizando el script `deploy.sh`:

   ```bash
   ./deploy.sh
   ```

2. Para ver los logs del contenedor durante el despliegue, ejecuta:

   ```sh
   ./deploy.sh --logs
   ```

3. Accede al endpoint `/metrics` en tu navegador o mediante `curl`:
   ```sh
   curl http://localhost:8000/metrics
   ```

## Pruebas en local con Docker Compose

1. Construye y despliega la aplicación utilizando el docker-compose.test.yaml :
   ```sh
   docker compose -f docker-compose.test.yml up --exit-code-from tests
   ```

## Uso local con Docker Compose

1. Construye y despliega la aplicación utilizando Docker Compose:

```sh
docker-compose up --build
```

Se ejecturán las pruebas unitarias para luego dejar la app disponible en el puerto 8000

## Obtiene las métricas

2. Accede al endpoint `/metrics` en tu navegador o mediante `curl`:
   ```sh
   curl http://localhost:8000/metrics
   ```

## Ejemplo de Respuesta

```json
{
  "cpu_usage": 15.0,
  "memory_total": 16777216000,
  "memory_used": 8598323200,
  "memory_free": 8188897280,
  "memory_percent": 51.2
}
```

# Build and Unit Test Workflow Multi-Stage

Este workflow de GitHub Actions está diseñado para construir y probar imágenes Docker automáticamente cuando hay un push en la rama `master` o `test` o cuando se crea un pull request. A continuación se describen los pasos principales del workflow:

1. **Configuración de QEMU y Docker Buildx**: Se configuran QEMU y Docker Buildx para permitir la construcción de imágenes multiplataforma.
2. **Inicio de sesión en Docker Hub**: Se autentica en Docker Hub utilizando credenciales almacenadas en los secretos del repositorio.
3. **Construcción y exportación de la imagen Docker**: Se construye la imagen Docker y se exporta al Docker Engine local sin empujarla a un registro.
4. **Pruebas unitarias en Docker**: Se ejecutan pruebas unitarias utilizando `pytest` dentro del contenedor Docker.
5. **Metadatos de Docker para la construcción final**: Se generan metadatos para la imagen final, incluyendo etiquetas y etiquetas de versión.
6. **Construcción y push de la imagen final a Docker Hub**: Se construye y empuja la imagen final a Docker Hub, soportando múltiples plataformas como `linux/amd64` y `linux/arm64`.

Este workflow asegura que las imágenes Docker se construyan y prueben automáticamente, mejorando la eficiencia y la confiabilidad del proceso de desarrollo.
