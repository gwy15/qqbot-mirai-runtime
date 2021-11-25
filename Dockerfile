# unziper
FROM debian:bullseye AS unzipper

WORKDIR /code

RUN apt-get update \
    && apt-get install -y unzip

COPY mcl-1.2.2.zip /code/

RUN unzip mcl-1.2.2.zip \
    && chmod +x ./mcl \
    && rm mcl-1.2.2.zip


# runner
FROM openjdk:11-jre-slim-bullseye

WORKDIR /code

ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=C.UTF-8 \
    TZ=Asia/Shanghai

COPY --from=unzipper /code/ /code
COPY                 mirai-api-http-v2.3.3.mirai.jar /code/plugins/

RUN java -jar mcl.jar --dry-run

CMD [ "java", "-jar", "/code/mcl.jar" ]
