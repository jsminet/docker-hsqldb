FROM java:8-jre-alpine
MAINTAINER JS Minet

ENV HSQLDB_VERSION=2.4.0

RUN apk add --no-cache wget \
	&& mkdir -p /opt/hsqldb/lib /opt/hsqldb/data \
	&& wget --progress=bar:force:noscroll -O /opt/hsqldb/lib/hsqldb.jar http://central.maven.org/maven2/org/hsqldb/hsqldb/${HSQLDB_VERSION}/hsqldb-${HSQLDB_VERSION}.jar \
	&& apk del wget

WORKDIR /opt/hsqldb/data

CMD java -cp ../lib/hsqldb.jar org.hsqldb.server.Server -database.0 ${DATABASE:-xdb} -dbname.0 ${DBNAME:-xdb} -remote_open ${REMOTE_OPEN:-true} && tail -f /dev/null

EXPOSE 9001