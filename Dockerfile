# unziper
FROM debian:bullseye AS unzipper

WORKDIR /code

RUN apt-get update \
    && apt-get install -y unzip

COPY mcl-2.1.2.zip /code/

RUN unzip mcl-2.1.2.zip \
    && chmod +x ./mcl \
    && rm mcl-2.1.2.zip


# runner
FROM openjdk:11-jre-slim-bullseye

WORKDIR /code

ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=C.UTF-8 \
    TZ=Asia/Shanghai

COPY --from=unzipper /code/ /code

RUN java -jar mcl.jar --dry-run

CMD [ "java", "-jar", "/code/mcl.jar" ]
