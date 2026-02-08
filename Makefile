.PHONY: setup registry build deploy stop clean

REGISTRY_COMPOSE_FILE=registry/docker-compose.yml
MAIN_COMPOSE_FILE=docker-compose.yml

setup: registry build deploy

registry:
	@echo "Starting local registry..."
	docker-compose -f $(REGISTRY_COMPOSE_FILE) up -d

build:
	@echo "Building and pushing images..."
	docker buildx bake --push

deploy:
	@echo "Starting main services..."
	docker-compose -f $(MAIN_COMPOSE_FILE) up -d
	./scripts/wait_for_password.sh

stop:
	@echo "Stopping services..."
	docker-compose -f $(MAIN_COMPOSE_FILE) down
	docker-compose -f $(REGISTRY_COMPOSE_FILE) down

clean: stop
	@echo "Cleaning up..."
	docker system prune -f
