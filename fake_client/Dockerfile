FROM python:3-slim

WORKDIR /app

COPY auto_request_client.py /app


RUN pip install requests && apt-get clean

CMD ["python3", "auto_request_client.py"]
