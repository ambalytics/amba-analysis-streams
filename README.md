# amba-analysis-streams
Generic Stream Processing Framework for processing of Events related to scientific literature entities.


## Setup

1. Create .env with the following variables:

| name | default value | comment |
| ---- | ------------- | ------- |
| KAFKA_BROKER_ID | 1 | |
| KAFKA_CREATE_TOPICS | events_unlinked:1:1,events_unlinked-discusses:3:1,events_unlinked-crossref:3:1,events_linked:1:1,events_linked-discusses:3:1,events_unknown:3:1,events_processed:1:1,events_processed-discusses:3:1,events_aggregated:3:1 | |
| KAFKA_ADVERTISED_HOST_NAME | kafka | |
| KAFKA_ZOOKEEPER_CONNECT | zookeeper:2181 | |
| KAFKA_ADVERTISED_PORT | 9092 | |
| KAFKA_ADVERTISED_LISTENERS_PREFIX | PLAINTEXT:// | |
| KAFKA_BOOTRSTRAP_SERVER | kafka:9092 | |
| POSTGRES_HOST | postgres | |
| POSTGRES_PORT | 5432 | |
| POSTGRES_DB | amba | |
| POSTGRES_USER | streams | |
| POSTGRES_PASSWORD | - (omitted for security) |  |
| TWITTER_BEARER_TOKEN | - (omitted for security) | see developer.twitter.com | |
| INFLUXDB_PORT | 8086 | |
| INFLUXDB_PASSWORD | - (omitted for security) | |
| INFLUXDB_USER | streams | |
| INFLUXDB_ORG | ambalytics | |
| INFLUXDB_BUCKET | history | |
| AWS_ACCESS_KEY_ID | - (omitted for security) | this is for certbot SSL DNS auth with Route53 |
| AWS_SECRET_ACCESS_KEY | - (omitted for security) | this is for certbot SSL DNS auth with Route53 |

2. Make sure ports 80 and 443 are free.
3. Optionally, get SSL certs first: comment out certbot:command in docker-compose.yml, then run `docker-compose up --no-deps certbot`
4. Run the stack (comment out certbot:command to prevent log spam): `docker-compose up`

## Update a container while keeping the rest running
0. merge into master and make sure the packaging was successful
1. ```
    docker pull <container source>
   ```
2. ```
    docker-compose up -d --no-deps --build <container name>
   ```

Example perculator:
```
 docker pull ghcr.io/ambalytics/amba-analysis-worker-perculator/amba-analysis-worker-perculator:latest
 docker-compose up -d --no-deps --build twitter-perculator
