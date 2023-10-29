name = wonyang's inception
DOCKER_COMPOSE = docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env
TOOLS = srcs/requirements/wordpress/tools/make_dir.sh \
	srcs/requirements/bonus/website/django/tools/make_dir.sh \
	srcs/requirements/bonus/portainer/tools/make_dir.sh

all: env_file launch

env_file:
	@if [ ! -f ./srcs/.env ]; then \
		printf "Please enter the content for .env file (end with EOF):\n"; \
		while IFS= read -r line || [ -n "$$line" ]; do \
			echo "$$line" >> ./srcs/.env; \
		done; \
	fi

launch: env_file
	@printf "Launch configuration $(name)..."
	@bash $(TOOLS)
	@$(DOCKER_COMPOSE) up -d

build: env_file
	@printf "Building configuration $(name)..."
	@bash $(TOOLS)
	@$(DOCKER_COMPOSE) up -d --build

down: env_file
	@printf "Stopping configuration $(name)..."
	@$(DOCKER_COMPOSE) down

re: down build

clean: down
	@printf "Cleaning configuration $(name)..."
	@docker system prune -a
	@rm -rf ~/data/{wordpress,mariadb,website,portainer}/*
	@rm -f ./srcs/.env

fclean:
	@printf "Total clean of all configurations docker"
	@docker stop $$(docker ps -qa)
	@docker system prune --all --force --volumes
	@docker network prune --force
	@docker volume prune --force
	@rm -rf ~/data/{wordpress,mariadb,website,portainer}/*
	@rm -f ./srcs/.env

logs:
	@cd srcs && docker-compose logs

ps:
	@cd srcs && docker-compose ps

.PHONY	: all env_file launch build down re clean fclean logs ps
