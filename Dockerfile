FROM python:3.8.2-alpine3.11

# RUN apt-get update && \
#     apt-get install -y -q ffmpeg mpg123 vorbis-tools lame flac && \
#     rm -rf /var/lib/apt/lists/*
RUN apk --no-cache add  libjpeg-turbo \
                        sqlite \
                        zlib \
                        jpeg \
                        pcre \
                        sudo \
                        gcc \
                        musl-dev \
                        zlib-dev \
                        jpeg-dev \
                        pcre-dev \
                        ffmpeg \
                        flac \
                        lame \
                        mpg123 \
                        vorbis-tools \
                        screen \
                        linux-headers
ENV \
    UID=1000 \
    GID=1000 \
    USUARIO=admin \
    PASSWORD=admin

VOLUME /data /config
COPY supysonic.conf /config/supysonic.conf
RUN ln -s /config/supysonic.conf /etc/supysonic

WORKDIR /app
RUN pip install gunicorn https://github.com/spl0k/supysonic/archive/master.tar.gz

COPY app.py /app/app.py
# COPY supysonic.conf /etc/supysonic

# VOLUME [ \
#     "/data", \
#     "/media", \
#     "/etc/supysonic" \
# ]
EXPOSE 8000
COPY init.sh init.sh
RUN chmod 777 init.sh
# 4 workers, 180 secs timeout due to transcoding

CMD "./init.sh"

# ENTRYPOINT [ "/bin/sh" ]