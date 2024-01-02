@echo off
REM Exit on error
setlocal EnableDelayedExpansion

REM Get the directory of the script
SET "DIR=%~dp0"
cd /d "%DIR%"

REM Run the Docker command
docker run --rm -it --network=host ^
    -v %cd%/flyway-migrations:/flyway/flyway-migrations ^
    -v %cd%/flyway.conf:/flyway/conf/flyway.conf ^
    flyway/flyway:9.21 migrate

cd /d %OLDPATH%
endlocal