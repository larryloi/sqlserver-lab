FROM mcr.microsoft.com/mssql/server:2022-latest

# Use build args for non-secret defaults. Do NOT bake SA passwords into images.
ARG MSSQL_PID=Developer
ENV ACCEPT_EULA=Y
ENV MSSQL_PID=$MSSQL_PID

# If you need a JDBC driver in the image, copy it in during build and update
# the CLASSPATH. Omit this step if you don't have the JAR in the build context.
# Example (uncomment to use):
# COPY mysql-connector-java-8.0.30.jar /opt/mssql/lib/
# ENV CLASSPATH="$CLASSPATH:/opt/mssql/lib/mysql-connector-java-8.0.30.jar"

# Expose the SQL Server port
EXPOSE 1433

# Start SQL Server. Runtime secrets (SA password) should be provided via
# environment variables, docker secrets, or an external secrets manager.
CMD ["/opt/mssql/bin/sqlservr"]
