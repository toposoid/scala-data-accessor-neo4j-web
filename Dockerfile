FROM toposoid/toposoid-scala-lib:0.5

WORKDIR /app
ARG TARGET_BRANCH
ARG JAVA_OPT_XMX
ENV DEPLOYMENT=local
ENV _JAVA_OPTIONS="-Xms512m -Xmx"${JAVA_OPT_XMX}

RUN git clone https://github.com/toposoid/scala-data-accessor-neo4j-web.git \
&& cd scala-data-accessor-neo4j-web \
&& git fetch origin ${TARGET_BRANCH} \
&& git checkout ${TARGET_BRANCH} \
&& sbt playUpdateSecret 1> /dev/null \
&& sbt dist \
&& cd /app/scala-data-accessor-neo4j-web/target/universal \
&& unzip -o scala-data-accessor-neo4j-web-0.5.zip


COPY ./docker-entrypoint.sh /app/
ENTRYPOINT ["/app/docker-entrypoint.sh"]

