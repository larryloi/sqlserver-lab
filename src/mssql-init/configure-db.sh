#!/bin/bash
# wait for MSSQL server to start
export STATUS=1
i=0

sleep 5    # SQL server avaliable for connection after 5 seconds
while [[ $STATUS -ne 0 ]] && [[ $i -lt 30 ]]; do
	i=$i+1
	${SQLCMD} -t 1 -U sa -P $SA_PASSWORD -Q "SELECT 1" -C >> /dev/null
	STATUS=$?
done

if [ $STATUS -ne 0 ]; then 
	echo "Error: MSSQL SERVER took more than thirty seconds to start up."
	exit 1
fi

echo -e "\n>>> Setting up databases and permissions ...\n"
${SQLCMD} -S localhost -U sa -P $SA_PASSWORD -d master -C -i /mssql-init/ACL.sql

### The below are some sample data load into database
#echo -e "\n>>> Creating Tzdb schema for ${DM_SQLSVR_DATABASE} ...\n"
#/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $SA_PASSWORD -d ${DST_DB_NAME} -i /mssql-init/create_Tzdb_tables.sql
#  #echo -e "\n>>> Parparing Tzdb data for ${DM_SQLSVR_DATABASE} ...\n"
#  /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $SA_PASSWORD -d ${DST_DB_NAME} -i /mssql-init/insert_Tzdb_data.sql
