SHELL := /bin/bash

dev-up:
	docker compose -f docker-compose-dev.yml --env-file .dev.env up -d --build

dev-down:
	docker compose -f docker-compose-dev.yml --env-file .dev.env down

dev-stop:
	docker compose -f docker-compose-dev.yml --env-file .dev.env stop

dev-logs:
	docker compose -f docker-compose-dev.yml --env-file .dev.env logs -f

dev: dev-up dev-logs

dev-delete:
	docker compose -f docker-compose-dev.yml --env-file .dev.env down -v

dev-backup:
	MONGO_INITDB_ROOT_USERNAME="$$(grep '^MONGO_INITDB_ROOT_USERNAME=' .dev.env | cut -d= -f2-)" \
	MONGO_INITDB_ROOT_PASSWORD="$$(grep '^MONGO_INITDB_ROOT_PASSWORD=' .dev.env | cut -d= -f2-)" \
	./mongodb/backup_db.sh
