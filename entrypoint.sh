#!/bin/sh

CONTAINER_INIT_STARTUP="CONTAINER_INIT_STARTUP"

echo "Entrypoint file started..."

if [ "$1" = "init" ]; then
    # script that should run on FIRST/INITIAL execution
    echo "Initial Execution [Setup + Migration]"

    php artisan config:clear
    php artisan migrate:fresh --seed
    php artisan package:discover --ansi
    php artisan serve --host 0.0.0.0
elif [ "$1" = "migrate" ]; then
    echo "Do a migration Execution"

    php artisan migrate
    php artisan serve --host 0.0.0.0
else
    # script that should run on > 2nd (NORMAL) execution
    echo "Normal Execition"

    php artisan serve --host 0.0.0.0
fi