FROM toposoid/toposoid-core:0.3

WORKDIR /app
ARG TARGET_BRANCH
ENV DEPLOYMENT=local
ENV _JAVA_OPTIONS="-Xms512m -Xmx4g"

RUN git clone https://github.com/toposoid/scala-data-accessor-neo4j-web.git \
&& cd scala-data-accessor-neo4j-web \
&& git fetch origin ${TARGET_BRANCH} \
&& git checkout ${TARGET_BRANCH} \
&& sbt playUpdateSecret 1> /dev/null \
&& sbt dist \
&& cd /app/scala-data-accessor-neo4j-web/target/universal \
&& unzip -o scala-data-accessor-neo4j-web-0.3.zip


COPY ./docker-entrypoint.sh /app/
ENTRYPOINT ["/app/docker-entrypoint.sh"]

