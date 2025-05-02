# sqlserver-lab

### How to use

```bash
root@db01:/docker/sqlserver-lab# make up
docker compose up -d
[+] Running 3/3
 ✔ Network sqlserver-lab_integration       Created 
 ✔ Volume "sqlserver-lab_sql-server-data"  Created  
 ✔ Container sqlserver                     Started      
root@db01:/docker/sqlserver-lab#
root@db01:/docker/sqlserver-lab#
root@db01:/docker/sqlserver-lab# make shell
docker compose exec sqlserver bash
root@sqlserver:/#
root@db01:/docker/sqlserver-lab# make shell
docker compose exec sqlserver bash
root@sqlserver:/#
root@sqlserver:/# bash /mssql-init/configure-db.sh

>>> Setting up databases and permissions ...


>>> Setting up databases ...

Changed database context to 'inventory'.
Update mask evaluation will be disabled in net_changes_function because the CLR configuration option is disabled.
Job 'cdc.inventory_capture' started successfully.
Job 'cdc.inventory_cleanup' started successfully.
Changed database context to 'dwh'.
root@sqlserver:/#

```