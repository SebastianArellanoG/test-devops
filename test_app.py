import pytest
from flask import Flask
from flask.testing import FlaskClient
import psutil
from unittest.mock import patch, MagicMock
import json
from app import app  # Asegúrate de importar tu aplicación Flask correctamente

@pytest.fixture
def client():
    with app.test_client() as client:
        yield client

@patch('psutil.cpu_percent')
@patch('psutil.virtual_memory')
def test_get_metrics(mock_virtual_memory, mock_cpu_percent, client):
    # Configurar los valores de retorno de los mocks
    mock_cpu_percent.return_value = 50.0
    mock_virtual_memory.return_value = MagicMock(
        total=8000000, used=4000000, free=3000000, percent=50.0,
        available=3000000, active=2000000, inactive=1000000,
        buffers=500000, cached=1000000, shared=500000, slab=250000
    )

    # Generar los datos esperados a partir de los valores de los mocks
    expected_data = {
        'cpu_usage': mock_cpu_percent.return_value,
        'memory_total': mock_virtual_memory.return_value.total,
        'memory_used': mock_virtual_memory.return_value.used,
        'memory_free': mock_virtual_memory.return_value.free,
        'memory_percent': mock_virtual_memory.return_value.percent
    }

    # Hacer una solicitud GET al endpoint /metrics
    response = client.get('/metrics')

    # Verificar el código de estado de la respuesta
    assert response.status_code == 200

    # Verificar el contenido de la respuesta
    data = json.loads(response.data)
    assert data == expected_data
