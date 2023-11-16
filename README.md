# rocky-nagios
Nagios Core on top of Rocky Linux 9.

## Run
```
docker run --name rocky-nagios -d -t -p 8000:80 subrock/rocky-nagios
```

## Compose
You can build and launch using compose. Create a directory and place Dockerfile, docker-compose.yaml and startup.sh in a directory.
```
docker compose build
docker compose up
docker compose up -d
```
## Access
```
http://localhost:8000/nagios/
```
