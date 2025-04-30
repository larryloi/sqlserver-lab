#!/bin/bash

${SQLCMD} -S localhost -U sa -P $SA_PASSWORD -d master -C -i /mssql-init/destroy.sql
