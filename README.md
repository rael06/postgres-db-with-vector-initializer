# postgres-db-with-vector-initializer

In order to initialize the db, please follow this steps:

- set the following env variables into the .env file:
  - COMPOSE_PROJECT_NAME=the_docker_containers_name_you_want (ex: my_project)
  - POSTGRES_USER=the_admin_user_name (ex: my_username)
  - POSTGRES_PASSWORD=the_admin_user_password (ex: my_password)
  - DATABASE_NAME=the_database_name (ex: my_project)
  - DATABASE_USERNAME=the_user_name (ex: my_username)
  - DATABASE_PASSWORD=the_user_password (ex: my_password)
  - DATABASE_PORT=the_database_port (ex: 5451, try to set a port that will not conflict with other ports especially the default 5432 otherwise you could not run them simultaneously)
- Adjust the file init-data.sh to your needs for embeddings tables, remove the '--' to uncomment it if you need it, however you can create the tables by yourself later once connected to the db
- run this command: `docker compose --env-file ./.env build && docker compose --env-file ./.env up -d` (here we first build the images, then inject the env file by its path to run the containers)
- Or run these command for Windows:
  - `docker compose --env-file ./.env build`
  - `docker compose --env-file ./.env up -d`
- Or this all-in-one:
  `docker compose --env-file ./.env up --build -d`

Beware to run docker-compose or docker compose depending on your docker version
Beware to use right permission as sudo if needed

- wait a minute during the initialization of the db

You're done!

Optional: you can delete the <DATABASE_NAME>-postgres-db-initializer container and image by running the following commands:

- `docker rm <DATABASE_NAME>-postgres-db-initializer`
- `docker rmi <DATABASE_NAME>-postgres-db-initializer:latest`
