FROM mcr.microsoft.com/java/jre:11-zulu-ubuntu

WORKDIR /code

COPY mcl-1.0.5.zip /code/

ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=C.UTF-8 \
    TZ=Asia/Shanghai

RUN apt-get update && apt-get install -y unzip \
    && unzip mcl-1.0.5.zip \
    && chmod +x mcl \
    && rm mcl-1.0.5.zip \
    && rm -rf /var/lib/apt/lists/*

COPY mirai-api-http-v2.1.0.mirai.jar /code/plugins/

RUN java -jar mcl.jar --dry-run

ENTRYPOINT [ "java", "-jar", "/code/mcl.jar" ]
CMD []
