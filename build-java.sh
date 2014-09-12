#!/bin/sh

cd java7
docker build -t quintenk/jdk7-oracle .
cd ..

cd java8
docker build -t quintenk/jdk8-oracle .
cd ..
