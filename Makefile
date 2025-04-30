DEFAULT_CT=sqlserver

volume.rm.all:
	docker volume rm $$(docker volume ls -qf dangling=true)

volume.list:
	docker volume ls

ps:
	docker compose ps

up:
	docker compose up -d

down:
	docker compose down

logs:
	docker compose logs -f

shell:
	docker compose exec $(DEFAULT_CT) bash