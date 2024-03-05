DOCKER_COMPOSE_FILE="`pwd`/dev/docker-compose.yml"
DOCKER_COMPOSE_CMD=docker-compose -f $(DOCKER_COMPOSE_FILE)

build_run:
	$(DOCKER_COMPOSE_CMD) up --force-recreate --build -d

start:
	$(DOCKER_COMPOSE_CMD) up -d

stop:
	$(DOCKER_COMPOSE_CMD) stop

check:
	@pre-commit run --all-files

init_dev:
	# @brew install pyenv-virtualenv
	python3 -m venv .venv
	@.venv/bin/poetry install --no-root

docker_clean:
	docker system prune -a
