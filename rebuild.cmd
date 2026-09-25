call init-ssh.cmd
docker compose build
docker compose up -d
docker compose logs dev
