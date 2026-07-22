.PHONY: config build up down logs backup

config:
	docker compose --env-file .env.example config

build:
	docker compose --env-file .env.example build

up:
	docker compose --env-file .env up -d --build

down:
	docker compose --env-file .env down

logs:
	docker compose --env-file .env logs -f --tail=200

backup:
	docker compose --env-file .env exec moodle moodle-backup
