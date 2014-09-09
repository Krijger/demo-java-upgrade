FROM quintenk/tomcat:7

# Install dependencies for project that do not change per check-in
RUN apt-get -y install libimage-exiftool-perl
RUN apt-get -y install build-essential checkinstall libx11-dev libxext-dev zlib1g-dev libpng12-dev libjpeg-dev libfreetype6-dev libxml2-dev && wget -q -O - http://www.imagemagick.org/download/ImageMagick.tar.gz | tar -C /tmp -xz && cd tmp/ImageMagick-6.* && ./configure && make && make install && ldconfig /usr/local/lib && rm -rf tmp/ImageMagick-6.*

RUN rm -rf /var/lib/tomcat7/webapps/*

RUN echo 'CATALINA_BASE="/var/lib/tomcat7"' >> /etc/default/tomcat7
RUN echo 'JAVA_HOME=/usr/lib/jvm/java-7-oracle' >> /etc/default/tomcat7 
RUN echo 'JAVA_OPTS="${JAVA_OPTS} -Xdebug -Xrunjdwp:transport=dt_socket,address=8000,server=y,suspend=n"' >> /etc/default/tomcat7
RUN echo 'MEMORY_OPTS="-Xmx512m -XX:+HeapDumpOnOutOfMemoryError -XX:MaxPermSize=128m"' >> /etc/default/tomcat7
RUN echo 'APP_OPTS="-DAPP_ENV=${CATALINA_BASE}/conf -Dspring.profiles.active=dev"' >> /etc/default/tomcat7
RUN echo 'LOG_OPTS="-Dlog4j.debug=true -Dlog4j.configuration=file://${CATALINA_BASE}/conf/log4j.properties"' >> /etc/default/tomcat7
RUN echo 'DOCKER_OPTS="-DMONGO_SERVER_URL=${MONGO_PORT_27017_TCP_ADDR} -DELASTICSEARCH_SERVER_URL=${ELASTICSEARCH_PORT_9200_TCP_ADDR}"' >> /etc/default/tomcat7
RUN echo 'CATALINA_OPTS="${MEMORY_OPTS} ${LOG_OPTS} ${APP_OPTS} ${DOCKER_OPTS}"' >> /etc/default/tomcat7

# add supervisord configuration and configuration files
ADD log4j.properties /etc/tomcat7/
ADD beheer.properties /etc/tomcat7/
ADD mail-templates /etc/tomcat7/mail-templates
RUN cd /etc/tomcat7 && chown root:tomcat7 log4j.properties && chown root:tomcat7 beheer.properties && chown -R root:tomcat7 mail-templates

# create NFS directories
RUN mkdir /etc/nfsupload && mkdir /etc/videofiles && chown root:tomcat7 /etc/nfsupload && chown root:tomcat7 /etc/videofiles && chmod 775 /etc/nfsupload && chmod 775 /etc/videofiles

# Assume the project has been built and that ROOT.war is in our docker build directory (containing the Dockerfile)
ADD ROOT.war /var/lib/tomcat7/webapps/
RUN chown root:tomcat7 /var/lib/tomcat7/webapps/ROOT.war

CMD supervisord -c /etc/supervisor.conf
