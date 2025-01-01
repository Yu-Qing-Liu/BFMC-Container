#!/bin/bash

docker compose -f docker-compose.build.yml build && docker compose -f docker-compose.dev.yml build
docker rm -f $(docker ps -aq)
docker rmi -f ros-ubuntu:latest
