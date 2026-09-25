call init-ssh.cmd
docker compose build --no-cache
docker compose up -d
docker compose logs dev
