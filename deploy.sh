#!/bin/sh

COMPOSE_FOLDER=~/amba-analysis-streams

cd $COMPOSE_FOLDER
git pull origin main

docker-compose down --volumes --remove-orphans

# delete images
#docker image rm docker.pkg.github.com/ambalytics/amba-bib-search/amba-bib-search:latest
#docker image rm docker.pkg.github.com/ambalytics/amba-bib-entities/amba-bib-entities:latest
#docker image rm docker.pkg.github.com/ambalytics/amba-analysis-networks/amba-analysis-networks:latest

# pull images
docker pull ghcr.io/ambalytics/amba-connector-twitter/amba-connector-twitter:latest
docker pull ghcr.io/ambalytics/amba-analysis-worker-perculator/amba-analysis-worker-perculator:latest
docker pull ghcr.io/ambalytics/amba-analysis-worker-discussion/amba-analysis-worker-twitter:latest
docker pull ghcr.io/ambalytics/amba-connector-mongodb/amba-connector-mongodb:latest
docker pull ghcr.io/ambalytics/amba-analysis-worker-pubfinder/amba-analysis-worker-pubfinder:latest
docker pull ghcr.io/ambalytics/amba-analysis-streams-api/amba-analysis-streams-api:latest
docker pull ghcr.io/ambalytics/amba-analysis-worker-aggregator/amba-analysis-worker-aggregator:latest

docker-compose build --force-rm
docker-compose up -d
