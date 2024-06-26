docker-compose down
docker-compose --env-file dev.env up -d --build
docker image prune -f