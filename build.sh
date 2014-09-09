#!/bin/sh

mvn clean install

cd java8
docker build -t quintenk/jdk8-oracle .
cd ..

docker build -t demoapp .

docker run -p 8080:8080 -it demoapp
