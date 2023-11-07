import threading
import random
import requests
import time
import logging

# Configurazione del logger
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(name)s - %(levelname)s - %(message)s')

URLS = [
    'http://sde-web_service_container:8181/',
    'http://sde-web_service_container:8181/',
    'http://sde-web_service_container:8181/hello',
    'http://sde-web_service_container:8181/delayed',
    'http://sde-web_service_container:8181/404'
]

def send_requests(url):
    logger = logging.getLogger(url)
    while True:
        try:
            response = requests.get(url)
            # logger.info(f"{url} {response.status_code}")
        except requests.exceptions.RequestException as e:
            logger.error(f"Error while fetching {url}: {e}")

        # Aspetta un tempo casuale tra 0 e 500 millisecondi
        s = random.randint(0, 500) / 1000
        time.sleep(s)

if __name__ == "__main__":
    threads = []
    for url in URLS:
        thread = threading.Thread(target=send_requests, args=(url,))
        threads.append(thread)
        thread.start()

    for thread in threads:
        thread.join()
