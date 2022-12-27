#!/bin/bash

docker build -t ubuntu-18-04-mx6sl-android-oreo . --no-cache \
	--build-arg USER_ID=$(id -u) \
	--build-arg GID=$(id -g)
