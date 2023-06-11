# programme.lv database

## starting a local database

The folder `local-proglv-db` contains a docker-compose file that will start a local database.
Alternatively, you can start a local database using the following command:

```bash
docker run -d --name proglv-db -p 5432:5432 -e POSTGRES_PASSWORD=proglv -e POSTGRES_USER=proglv -e POSTGRES_DB=proglv postgres:12.2
```

will start a local database on port 5432 with the user `proglv` and the password `proglv`.

## connecting to the database

Personally, I use JetBrains DataGrip to connect to the database. You can download it [here](https://www.jetbrains.com/datagrip/).
You can also use dbeaver, which is free and open source. You can download it [here](https://dbeaver.io/).

Or you can use the command line:

```bash
psql -h localhost -p 5432 -U proglv -d proglv
```

## database migrations

We use [Flyway](https://flywaydb.org/) to manage database migrations. The migrations are located in the `flyway-migrations` folder.