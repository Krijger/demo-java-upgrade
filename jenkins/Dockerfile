FROM ubuntu
MAINTAINER Pini Reznik "p.reznik@uglyduckling.nl"

RUN echo deb http://archive.ubuntu.com/ubuntu precise universe >> /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -q -y openjdk-7-jre-headless git
ENV JENKINS_HOME /var/jenkins_home

ADD jenkins.war /root/jenkins.war
# ADD http://mirrors.jenkins-ci.org/war/latest/jenkins.war /root/jenkins.war

EXPOSE 8080
CMD ["java", "-jar", "/root/jenkins.war"]



