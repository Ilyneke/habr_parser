DOCKER_COMPOSE_FILE="`pwd`/dev/docker-compose.yml"
DOCKER_COMPOSE_CMD=docker-compose -f $(DOCKER_COMPOSE_FILE)

build_run:
	$(DOCKER_COMPOSE_CMD) up --force-recreate --build -d

migrate:
	$(DOCKER_COMPOSE_CMD) exec -T web python manage.py migrate

db_restore:
	$(DOCKER_COMPOSE_CMD) exec -T db psql -U postgres postgres < dump.sql

db_remove:
	$(DOCKER_COMPOSE_CMD) down --volumes

start:
	$(DOCKER_COMPOSE_CMD) up -d

stop:
	$(DOCKER_COMPOSE_CMD) stop
