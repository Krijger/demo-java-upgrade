FROM quintenk/jdk8-oracle

ADD target/demoapp-1.0-SNAPSHOT.jar /root/demoapp-1.0-SNAPSHOT.jar

EXPOSE 80

CMD java -jar /root/demoapp-1.0-SNAPSHOT.jar
