#!/usr/bin/env bash

set -e

PORT=5432
HOST=
NAME=
USER=
VERSION=
PASSWORD=
INIT_FILE='_init.sql'
INIT_DIR='/api'
SCHEMA=api

while getopts h:p:d:u:v:w:i:s: option
do
    case "${option}" in
    h) HOST=$OPTARG;;
    p) PORT=$OPTARG;;
    d) NAME=$OPTARG;;
    u) USER=$OPTARG;;
    v) VERSION=$OPTARG;;
    w) PASSWORD=$OPTARG;;
    i) INIT_FILE=$OPTARG;;
    esac
done

if [[ -z $HOST ]] || [[ -z $PORT ]] || [[ -z $NAME ]] || [[ -z $PASSWORD ]] || [[ -z $USER ]] || [[ -z $VERSION ]] || [[ -z $INIT_FILE ]];
then
  echo "Usage"
  exit 1;
fi;

cd $INIT_DIR
INIT_DIR=$(pwd)

cp -R $INIT_DIR /tmp$INIT_DIR
cd /tmp$INIT_DIR
DB_SCHEMA_PART="$(echo $VERSION | sed s/\\./_/g)" && \
find -type f -name '*.sql' | xargs sed -i "s/api/api_$DB_SCHEMA_PART/g"
PGPASSWORD=$PASSWORD psql -U ${USER} -h ${HOST} -p ${PORT} -d ${NAME} -c "drop schema if exists api_$DB_SCHEMA_PART cascade;"
PGPASSWORD=$PASSWORD psql -U ${USER} -h ${HOST} -p ${PORT} -d ${NAME} -f ${INIT_FILE}
PGPASSWORD=$PASSWORD psql -U ${USER} -h ${HOST} -p ${PORT} -d ${NAME} -c "alter role $USER set search_path TO public,api_$DB_SCHEMA_PART"

