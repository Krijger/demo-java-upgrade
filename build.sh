#!/bin/sh

mvn clean install

docker build -t demoapp .

docker run -p 8080:8080 -it demoapp
