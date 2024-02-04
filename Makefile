name = wonyang's inception
DOCKER_COMPOSE = docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env

all: up

env_file:
	@if [ ! -f ./srcs/.env ]; then \
		printf "Please enter the content for .env file (end with EOF):\n"; \
		while IFS= read -r line || [ -n "$$line" ]; do \
			echo "$$line" >> ./srcs/.env; \
		done; \
	fi

diractory:
	@bash srcs/requirements/wordpress/tools/make_dir.sh
	@bash srcs/requirements/bonus/website/django/tools/make_dir.sh
	@bash srcs/requirements/bonus/portainer/tools/make_dir.sh

up: env_file diractory
	@printf "Launch configuration $(name)..."
	@$(DOCKER_COMPOSE) up -d

build: env_file diractory
	@printf "Building configuration $(name)..."
	@$(DOCKER_COMPOSE) up -d --build

down: env_file
	@printf "Stopping configuration $(name)..."
	@$(DOCKER_COMPOSE) down

re: down build

clean: down
	@printf "Cleaning configuration $(name)..."
	@docker system prune -a --volumes

fclean:
	@printf "Total clean of all configurations docker"
	@docker stop $$(docker ps -qa)
	@docker system prune --all --force --volumes
	@rm -rf ~/data/{wordpress,mariadb,website,portainer}/*
	@rm -f ./srcs/.env

logs:
	@cd srcs && docker-compose logs

ps:
	@cd srcs && docker-compose ps

.PHONY	: all env_file launch build down re clean fclean logs ps
