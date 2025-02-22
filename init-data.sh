#!/bin/sh
set -e

if [ -n "${DATABASE_USERNAME:-}" ] && [ -n "${DATABASE_PASSWORD:-}" ]; then
    psql -v ON_ERROR_STOP=1 postgresql://$POSTGRES_USER:$POSTGRES_PASSWORD@postgres:5432/$POSTGRES_DB <<-EOSQL
		CREATE DATABASE "${DATABASE_NAME}";
		
		-- Create user only if it doesn't exist
		DO \$\$
		BEGIN
			IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = '${DATABASE_USERNAME}') THEN
				CREATE USER ${DATABASE_USERNAME} WITH PASSWORD '${DATABASE_PASSWORD}';
			END IF;
		END
		\$\$;
		
		GRANT ALL PRIVILEGES ON DATABASE "${DATABASE_NAME}" TO "${DATABASE_USERNAME}";
        
        CREATE EXTENSION vector;

        \c ${DATABASE_NAME}
        CREATE EXTENSION vector;

        -- CREATE TABLE IF NOT EXISTS embeddings_table (
        --     id SERIAL PRIMARY KEY,
        --     metadata_name TEXT, -- Adjust the column name and type according to your needs
        --     embedding VECTOR(768)  -- Adjust the dimension according to your model
        -- );

	EOSQL
else
    echo "SETUP INFO: No Environment variables given!"
fi

exit 0
