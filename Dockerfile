FROM mcr.microsoft.com/java/jre:11-zulu-ubuntu

WORKDIR /code

COPY mcl-1.0.5.zip /code/

RUN apt-get update && apt-get install -y unzip \
    && unzip mcl-1.0.5.zip \
    && chmod +x mcl \
    && rm mcl-1.0.5.zip \
    && rm -rf /var/lib/apt/lists/*

COPY mirai-api-http-v2.0.2.mirai.jar /code/plugins/

RUN java -jar mcl.jar --dry-run

ENTRYPOINT [ "java", "-jar" "mcl.jar" ]
CMD [ "" ]
