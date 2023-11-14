import requests
import time
import logging

# Configurazione del logger
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(name)s - %(levelname)s - %(message)s')

URLS = [
    'http://sde-web_service_container:8181/',
    'http://sde-web_service_container:8181/hello',
    'http://sde-web_service_container:8181/404'
]

if __name__ == "__main__":
    while(1):
        for url in URLS:
            response = requests.get(url)
            logging.info(f"Response from {url}: {response.status_code}")
            time.sleep(0.3)


