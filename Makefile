# Automate commands

up:
	docker compose up -d --build

down:
	docker compose down

prune:
	docker volume prune -a
	docker network prune
	docker system prune -a
	docker builder prune -a

show:
	docker ps -a

doune:
	docker compose down
	docker volume prune -a
	docker network prune
	docker system prune -a
	docker builder prune -a