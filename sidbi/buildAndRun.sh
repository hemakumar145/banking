#!/usr/bin/env bash
mvn clean package && docker build -t q/sidbi .
docker rm -f sidbi || true && docker run -d -p 8080:8080 -p 9990:9990 --name sidbi q/sidbi
