name = inception

all:
	@printf "Launch configuration ${name}...\n"
	@bash srcs/requirements/wordpress/tools/make_dir.sh
	@bash srcs/requirements/bonus/website/django/tools/make_dir.sh
	@bash srcs/requirements/bonus/portainer/tools/make_dir.sh
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env up -d

build:
	@printf "Building configuration ${name}...\n"
	@bash srcs/requirements/wordpress/tools/make_dir.sh
	@bash srcs/requirements/bonus/website/django/tools/make_dir.sh
	@bash srcs/requirements/bonus/portainer/tools/make_dir.sh
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env up -d --build

down:
	@printf "Stopping configuration ${name}...\n"
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env down

re: down
	@printf "Rebuild configuration ${name}...\n"
	@bash srcs/requirements/wordpress/tools/make_dir.sh
	@bash srcs/requirements/bonus/website/django/tools/make_dir.sh
	@bash srcs/requirements/bonus/portainer/tools/make_dir.sh
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env up -d --build

clean: down
	@printf "Cleaning configuration ${name}...\n"
	@docker system prune -a
	@sudo rm -rf ~/data/wordpress/*
	@sudo rm -rf ~/data/mariadb/*
	@sudo rm -rf ~/data/website/*
	@sudo rm -rf ~/data/portainer/*

fclean:
	@printf "Total clean of all configurations docker\n"
	@docker stop $$(docker ps -qa)
	@docker system prune --all --force --volumes
	@docker network prune --force
	@docker volume prune --force
	@sudo rm -rf ~/data/wordpress/*
	@sudo rm -rf ~/data/mariadb/*
	@sudo rm -rf ~/data/website/*
	@sudo rm -rf ~/data/portainer/*

logs:
	@cd srcs && docker-compose logs

ps:
	@cd srcs && docker-compose ps

.PHONY	: all build down re clean fclean logs ps
