# amba-analysis-streams
Generic Stream Processing Framework for processing of Events related to scientific literature entities.


## Setup

1. Create .env
2. Make sure ports 80 and 443 are free.
3. Optionally, get SSL certs first: comment out certbot:command in docker-compose.yml, then run `docker-compose up --no-deps certbot`
4. Run the stack (comment out certbot:command to prevent log spam): `docker-compose up`
