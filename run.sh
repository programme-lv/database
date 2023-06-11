#! /usr/bin/bash


flyway migrate -url=jdbc:postgresql://localhost:5432/proglv -user=proglv -password=proglv -locations=filesystem:./flyway-migrations