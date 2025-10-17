include Makefile.env

CT=sqlserver

# Colors for output
RED := \033[31m
GREEN := \033[32m
YELLOW := \033[33m
BLUE := \033[34m
MAGENTA := \033[35m
CYAN := \033[36m
WHITE := \033[37m
RESET := \033[0m


.PHONY: help all build volume.rm.all volume.list ps up down logs shell

help:
	@echo -e "$(CYAN)Available commands:$(RESET)"
	@echo -e "  $(GREEN)make build$(RESET)            - Build Docker images"
	@echo -e "  $(GREEN)make volume.rm.all$(RESET)    - Remove all dangling Docker volumes"
	@echo -e "  $(GREEN)make volume.list$(RESET)      - List all Docker volumes"
	@echo -e "  $(GREEN)make ps$(RESET)               - List running Docker containers"
	@echo -e "  $(GREEN)make up$(RESET)               - Start Docker containers in detached mode"
	@echo -e "  $(GREEN)make down$(RESET)             - Stop and remove Docker containers"
	@echo -e "  $(GREEN)make logs$(RESET)             - Follow logs of Docker containers"
	@echo -e "  $(GREEN)make shell$(RESET)            - Open a bash shell in the '$(CT)' container"

all: build up

build:
	docker compose build


volume.rm.all:
	@echo "$(GREEN)Removing dangling Docker volumes...$(RESET)"
	@docker volume rm $$(docker volume ls -qf dangling=true)

volume.list:
	@echo "$(GREEN)Listing all Docker volumes...$(RESET)"
	@docker volume ls

ps:
	@echo "$(GREEN)Listing running Docker containers...$(RESET)"
	@docker compose ps

up:
	@echo "$(GREEN)Starting Docker containers in detached mode...$(RESET)"
	@docker compose up -d

down:
	@echo "$(GREEN)Stopping and removing Docker containers...$(RESET)"
	@docker compose down

logs:
	@echo "$(GREEN)Following logs of Docker containers...$(RESET)"
	@docker compose logs -f

shell:
	@echo "$(GREEN)Opening a bash shell in the '$(CT)' container...$(RESET)"
	@docker compose exec --user root $(CT) bash

.PHONY: wait-for-health
wait-for-health:
	@echo "$(GREEN)Waiting for '$(CT)' to become healthy...$(RESET)"
	@bash -c '\
	  i=0; \
	  until [ $$(docker inspect -f "{{.State.Health.Status}}" $(CT) 2>/dev/null) = "healthy" ] || [ $$i -gt 60 ]; do \
	    sleep 1; i=$$((i+1)); \
	  done; \
	  status=$$(docker inspect -f "{{.State.Health.Status}}" $(CT) 2>/dev/null || echo unknown); \
	  echo "Container health: $$status"; \
	  if [ "$$status" != "healthy" ]; then exit 1; fi'

