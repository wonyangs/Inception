name = inception
DOCKER_COMPOSE = docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env
TOOLS = srcs/requirements/wordpress/tools/make_dir.sh \
	srcs/requirements/bonus/website/django/tools/make_dir.sh \
	srcs/requirements/bonus/portainer/tools/make_dir.sh

all: launch

launch:
	@printf "Launch configuration ${name}...\n"
	@bash $(TOOLS)
	@$(DOCKER_COMPOSE) up -d

build:
	@printf "Building configuration ${name}...\n"
	@bash $(TOOLS)
	@$(DOCKER_COMPOSE) up -d --build

down:
	@printf "Stopping configuration ${name}...\n"
	@$(DOCKER_COMPOSE) down

re: down build

clean: down
	@printf "Cleaning configuration ${name}...\n"
	@docker system prune -a
	@sudo rm -rf ~/data/{wordpress,mariadb,website,portainer}/*

fclean:
	@printf "Total clean of all configurations docker\n"
	@docker stop $$(docker ps -qa)
	@docker system prune --all --force --volumes
	@docker network prune --force
	@docker volume prune --force
	@sudo rm -rf ~/data/{wordpress,mariadb,website,portainer}/*

logs:
	@cd srcs && docker-compose logs

ps:
	@cd srcs && docker-compose ps

.PHONY	: all launch build down re clean fclean logs ps
