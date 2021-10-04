FROM alpine:latest

RUN apk --no-cache add make alpine-sdk zlib-dev libaio-dev linux-headers coreutils libaio && \
    git clone https://github.com/axboe/fio --branch=fio-3.28 --depth=1 && \
    cd fio && ./configure && make -j`nproc` && make install && cd .. && rm -rf fio && \
    apk --no-cache del make alpine-sdk zlib-dev libaio-dev linux-headers coreutils

COPY ./docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["fio"]
