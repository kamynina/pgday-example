#!/usr/bin/env bash

docker-compose up -d postgres

# wait when postgres up and running
until
  docker-compose run --rm -e 'PGPASSWORD=example' deploy_api psql -U example -h postgres -d example -c "select 1";
do
sleep 1;
done

# deploy
docker-compose run --rm deploy_api bash /deploy.sh -h postgres -d example -u example -w example -v 1.1 -i _init.sql

# trace stored procedures
docker-compose run coverage -c trace -h postgres -u example -d example -w example

# run tests
docker-compose run --rm test -h postgres -u example -d example -w example -i /t/api/_init.sql 2> result/trace.txt > /dev/null

# generate report
docker-compose run coverage -c report -h postgres -u example -d example -w example

