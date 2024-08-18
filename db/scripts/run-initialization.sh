#! /bin/bash

# Wait to be sure that SQL Server came up
sleep 10s

# Run the setup script to create the DB and the schema in the DB
# Note: make sure that your password matches what is in the Dockerfile
for DB_NAME in $(echo $DB_NAMES | sed "s/,/ /g"); do
    echo "Creating database $DB_NAME"
    sqlcmd -S localhost -U sa -P "$MSSQL_SA_PASSWORD" \
        -d master -v DB_NAME="${DB_NAME}" \
        -i create-database.sql -C
done