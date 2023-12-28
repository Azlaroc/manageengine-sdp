#!/bin/bash

export UID=$(id -u)
export GID=$(id -g)

docker compose build
docker compose up -d
