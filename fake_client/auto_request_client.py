import requests
import random
import time

URLS = ['http://web_service_container:8181/', 'http://web_service_container:8181/hello', 'http://web_service_container:8181/delayed']

while True:
    for url in URLS:
        try:
            # Effettua la richiesta
            response = requests.get(url)
            print(f"{url}  {response.status_code}")
        except requests.exceptions.RequestException as e:
            print(e)
    
    # Aspetta un tempo casuale tra 0 e 500 millisecondi
    s = random.randint(0, 500) / 1000
    time.sleep(s)
