#!/bin/sh

cd java7
docker build -t quintenk/jdk-oracle:7 .
cd ..

cd java8
docker build -t quintenk/jdk-oracle:8 .
cd ..
