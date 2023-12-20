#!/usr/bin/env bash

RUNNING=$(docker inspect --format="{{ .State.Running }}" sidbi 2> /dev/null)
if [ $? -eq 1 ] || [ "$RUNNING" == "false" ]; then
    rm -rfv ./artifact/*.war

    docker run \
     -d \
     --rm \
     --name sidbi \
     -p 8080:8080 \
     -p 9990:9990 \
     -v "$(pwd)/artifact:/deployments" \
     ivonet/wildfly:15.0.1.Final
#     ivonet/payara:5.184

    echo "WildFly admin console credentials:"
    echo "Url: http://localhost:9990"
    echo "Usr: admin"
    echo "Pwd: s3cr3t"

    mvn clean package
else
    /usr/bin/osascript -e 'display notification "Stopping..." with title "sidbi"'
    docker rm -f sidbi
fi

