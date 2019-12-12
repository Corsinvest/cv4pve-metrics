@ECHO OFF
REM  This file is part of the cv4pve-metrics https://github.com/Corsinvest/cv4pve-metrics,
REM 
REM  This source file is available under two different licenses:
REM  - GNU General Public License version 3 (GPLv3)
REM  - Corsinvest Enterprise License (CEL)
REM  Full copyright and license information is available in
REM  LICENSE.md which is distributed with this source code.
REM 
REM  Copyright (C) 2016 Corsinvest Srl	GPLv3 and CEL
REM
TITLE Metrics Util

SET interactive=1
SET COMPOSE_CONVERT_WINDOWS_PATHS=1

ECHO %cmdcmdline% | FIND /i "/c"
IF %ERRORLEVEL% == 0 SET interactive=0

IF "%1"=="enter" (
    REM Enter attaches users to a shell in the desired container
    IF "%2"=="" (
        ECHO metrics-utils enter ^(influxdb^|^|chronograf^|^|kapacitor^|^|telegraf^|^|grafana^)
    ) ELSE (
        ECHO Entering ^/bin^/bash session in the %2 container...
        docker-compose exec %2 /bin/bash
    )
) ELSE IF "%1"=="logs" (
    REM Logs streams the logs from the container to the shell
    IF "%2"=="" (
        ECHO metrics-utils logs ^(influxdb^|^|chronograf^|^|kapacitor^|^|telegraf^|^|grafana^)
    ) ELSE (
        ECHO Following the logs from the %2 container...
        docker-compose logs -f %2
    )
) ELSE IF "%1"=="up" (
    docker-compose up -d --build
) ELSE IF "%1"=="down" (
    ECHO Stopping running metrics containers...
    docker-compose down
) ELSE IF "%1"=="restart" (
    ECHO Stopping all metrics processes...
    docker-compose down >NUL 2>NUL
    ECHO Starting all matrics processes...
    docker-compose up -d >NUL 2>NUL
    ECHO Services available!
) ELSE IF "%1"=="influxdb" (
    ECHO Entering the influx cli...
    docker-compose exec influxdb /usr/bin/influx
) ELSE (
    ECHO metrics-util commands:
    ECHO   up       -^> spin up the sandbox environment
    ECHO   down     -^> tear down the sandbox environment
    ECHO   restart  -^> restart the sandbox
    ECHO   influxdb -^> attach to the influx cli
    ECHO.
    ECHO   enter ^(influxdb^|^|kapacitor^|^|chronograf^|^|telegraf^|^|grafana^) -^> enter the specified container
    ECHO   logs  ^(influxdb^|^|kapacitor^|^|chronograf^|^|telegraf^|^|grafana^) -^> stream logs for the specified container
)

IF "%interactive%"=="0" rem PAUSE
EXIT /B 0
