#!/bin/bash

docker kill jenkins
docker rm jenkins
docker run -d --privileged -name jenkins -p 8000:8080 -v `pwd`/jenkins_home:/var/jenkins_home preznik/jenkins

