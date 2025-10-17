# sqlserver-lab

Quick local SQL Server sandbox using Docker Compose.

Prerequisites
- Docker and Docker Compose v2

Quick start

Run the containers in detached mode:

```bash
make up
```

Open a root shell in the SQL Server container:

```bash
make shell
```

Run the init scripts inside the container (example):

```bash
bash /mssql-init/configure-db.sh
```

Health and readiness
- The compose file includes a healthcheck that attempts a quick SQL query using the SA credentials defined in `env/sqlserver.env`.
- You can wait for the container to be healthy with:

```bash
make wait-for-health
```

Security notes
- Do NOT commit production secrets. `env/sqlserver.env` currently contains an example `SA_PASSWORD` used for local dev only. Consider using Docker secrets or an external secrets manager for anything sensitive.

Files of interest
- `docker-compose.yml` - service definition, volumes, healthcheck
- `Dockerfile` - optional image tweaks (does not embed secrets)
- `src/mssql-init` - initialization scripts executed inside the container

Issues / next steps
- Consider switching SA_PASSWORD to a Docker secret or environment injection in CI
- Add CI workflow to run the init scripts against a temporary container
