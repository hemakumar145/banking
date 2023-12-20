#!/usr/bin/env bash
#deploy="false"
deploy="true"

image=sidbi
version= 1.0-SNAPSHOT
latest=true

#OPTIONS="--no-cache --force-rm"
#OPTIONS="--no-cache"
#OPTIONS="--force-rm"
OPTIONS=""

docker build ${OPTIONS} -t q/${image}: 1.0-SNAPSHOT .
if [ "$?" -eq 0 ] && [ ${deploy} == "true" ]; then
    docker push q/${image}: 1.0-SNAPSHOT
    if [ "$latest" == "true" ]; then
        docker tag q/${image}: 1.0-SNAPSHOT q/${image}:latest
        docker push q/${image}:latest
    fi
fi