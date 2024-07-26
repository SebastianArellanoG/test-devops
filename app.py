from flask import Flask, jsonify
import psutil
import logging

app = Flask(__name__)

# Configuración de logging
logging.basicConfig(level=logging.INFO)

@app.route('/metrics', methods=['GET'])
def get_metrics():
    app.logger.info("Starting to collect metrics")
    cpu_usage = psutil.cpu_percent(interval=1)
    app.logger.info(f"CPU Usage: {cpu_usage}")
    memory_info = psutil.virtual_memory()
    app.logger.info(f"Memory Info: {memory_info}")
    metrics = {
        'cpu_usage': cpu_usage,
        'memory_total': memory_info.total,
        'memory_used': memory_info.used,
        'memory_free': memory_info.free,
        'memory_percent': memory_info.percent
    }
    app.logger.info(f"Metrics collected: {metrics}")
    return jsonify(metrics)

if __name__ == '__main__':
    app.run(host="0.0.0.0", port=8000)