#!/bin/bash

# Nombre de la imagen y del contenedor
IMAGE_NAME="psutil-metrics"
CONTAINER_NAME="metrics"


# Construir la imagen Docker
echo "Construyendo la imagen Docker..."
docker build -t $IMAGE_NAME .

# Detener y eliminar cualquier contenedor existente con el mismo nombre
if [ "$(docker ps -aq -f name=$CONTAINER_NAME)" ]; then
    echo "Deteniendo y eliminando el contenedor existente..."
    docker stop $CONTAINER_NAME
    docker rm $CONTAINER_NAME
fi

# Iniciar un nuevo contenedor Docker
echo "Iniciando un nuevo contenedor Docker..."
docker run -d --name $CONTAINER_NAME -p 8000:8000 --restart unless-stopped $IMAGE_NAME

# Mostrar los logs del contenedor condicionalmente
if [ "$1" == "--logs" ]; then
    echo "Mostrando los logs del contenedor..."
    docker logs -f $CONTAINER_NAME
fi


echo "Despliegue completado exitosamente."
