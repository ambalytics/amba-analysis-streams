#!/bin/sh

COMPOSE_FOLDER=~/amba-analysis-streams

cd $COMPOSE_FOLDER
git pull origin main

docker-compose down --volumes --remove-orphans

# pull images
docker pull ghcr.io/ambalytics/amba-connector-twitter/amba-connector-twitter:latest
docker pull ghcr.io/ambalytics/amba-analysis-worker-perculator/amba-analysis-worker-perculator:latest
docker pull ghcr.io/ambalytics/amba-analysis-worker-discussion/amba-analysis-worker-discussion:latest
docker pull ghcr.io/ambalytics/amba-analysis-worker-pubfinder/amba-analysis-worker-pubfinder:latest
docker pull ghcr.io/ambalytics/amba-analysis-streams-api/amba-analysis-streams-api:latest
docker pull ghcr.io/ambalytics/amba-analysis-worker-aggregator/amba-analysis-worker-aggregator:latest

docker-compose build --force-rm
docker-compose up -d
