#!/bin/bash

docker-compose -f docker-compose_env.yml --env-file env.txt up -d
#docker-compose -f docker-compose_env.yml --env-file env.txt down --remove-orphans --rmi all --volumes

exit 0
