#!/bin/sh

mvn clean install

docker build -t demoapp .

docker kill demoapp
docker rm demoapp
docker run --name demoapp -p 8000:8080 -d demoapp
