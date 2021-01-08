#!/usr/bin/env bash

echo $(eval "echo $@")

if [ -z "${DB_HOST}" ]
then
    echo "DB_HOST empty"
    eval "$(eval "echo $@")"
else
    echo "DB_HOST not empty"
    echo "/wait-for-it.sh ${DB_HOST} -t 90 -- $(eval "echo $@")"
    ./wait-for-it.sh ${DB_HOST} -t 90 -- $(eval "echo $@")
fi