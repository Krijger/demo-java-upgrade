FROM quintenk/jdk-oracle:7

ADD target/demoapp-1.0-SNAPSHOT.jar /root/demoapp-1.0-SNAPSHOT.jar

EXPOSE 80

CMD java -jar /root/demoapp-1.0-SNAPSHOT.jar
