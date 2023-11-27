# Monitoring & analysis of Web services

## Setup

Open a terminal and run the following commands:

```bash
cd Desktop/lab_folder
sudo docker-compose up
```

If you update the code, you can run the following commands to rebuild the images:

```bash
sudo docker-compose up --build
```

## Project structure

```
├── benchmark.sh
├── config
│   └── prometheus.yaml
├── docker-compose.yaml
├── express_app
├── frontend
├── README.md
└── volumes
    ├── grafana-data
    └── prometheus-data
```

## Services

Here is a list of the services that will be available after running the commands above.

### Dockerhub images

Those images are pulled from Dockerhub.

| Name | URL | Username | Password |
| --- | --- | --- | --- |
| Grafana | http://localhost:3000 | admin | password |
| Prometheus | http://localhost:9090 | | |
| Node Exporter | http://localhost:9100 | | |
<br/>

### Our web service

Those images are built from the Dockerfiles in the `express_app` folder.

| URL | Description |
| --- | --- |
| http://localhost:8181/app | frontend app |
| http://localhost:8181/api/ | homepage |
| http://localhost:8181/api/hello/ | hello world |
| http://localhost:8181/api/delayed | slow endpoint |
| http://localhost:8181/metrics | metrics endpoint |

