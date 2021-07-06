FROM ubuntu:20.04

WORKDIR /code

COPY mcl-1.0.5.zip /code/
COPY mirai-api-http-v2.0.2.mirai.jar /code/plugins/

RUN apt-get update && apt-get install -y unzip openjdk-11-jre-headless \
    && unzip mcl-1.0.5.zip \
    && chmod +x mcl \
    && rm mcl-1.0.5.zip \
    && rm -rf /var/lib/apt/lists/*

RUN java -jar mcl.jar --dry-run

ENTRYPOINT [ "java", "-jar" "mcl.jar" ]
CMD [ "" ]
