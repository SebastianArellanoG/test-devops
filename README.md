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
cd test-devops-junior
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

## Deploy y Test con Dockerfile

1. Construye y despliega la aplicación utilizando el script `test_and_deploy.sh`:
    ```sh
    ./test_and_deploy.sh
    ```

2. Para ver los logs del contenedor durante el despliegue, ejecuta:
    ```sh
    ./test_and_deploy.sh --logs
    ```

3. Accede al endpoint `/metrics` en tu navegador o mediante `curl`:
    ```sh
    curl http://localhost:8000/metrics
    ```

## Uso local con Docker Compose 

1. Para ejecutar las pruebas, utiliza el siguiente comando:
    ```sh
    docker-compose run tests
    ```
2. Construye y despliega la aplicación utilizando Docker Compose:
    ```sh
    docker-compose up --build
    ```
## Obtiene las métricas

3. Accede al endpoint `/metrics` en tu navegador o mediante `curl`:
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
