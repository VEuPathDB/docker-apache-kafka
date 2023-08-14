FROM amazoncorretto:19-alpine

ENV KAFKA_HOME=/opt/kafka \
    PATH=${PATH}:/opt/kafka/bin

RUN apk add --no-cache bash \
  && cd /opt \
  && wget https://dlcdn.apache.org/kafka/3.4.0/kafka_2.13-3.4.0.tgz -O /opt/kafka.tgz \
  && tar -xf kafka.tgz \
  && rm kafka.tgz \
  && mv kafka_2.13-3.4.0 kafka

COPY [ \
  "startup.sh", \
  "configuration.defaults.sh", \
  "server.properties.sh", \
  "./" \
]

CMD sh startup.sh