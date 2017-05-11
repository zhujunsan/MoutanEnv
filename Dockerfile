FROM zhujunsan/lnp:latest

MAINTAINER San <zhujunsan@gmail.com>

ENV THRIFT_VERSION 0.10.0

# Install Thrift
RUN apk add --update gcc g++ make automake autoconf bison flex && \
    curl -fSL http://mirror.cc.columbia.edu/pub/software/apache/thrift/$THRIFT_VERSION/thrift-$THRIFT_VERSION.tar.gz -o thrift.tar.gz && \
    tar -zxC /usr/src -f thrift.tar.gz && \
    rm thrift.tar.gz && \
    cd /usr/src/thrift-$THRIFT_VERSION && \
    ./configure --without-python && \
    make && \
    make install && \
    rm -rf /usr/src/thrift-$THRIFT_VERSION && \
    apk del gcc g++ make automake autoconf bison flex &&\
# Install Redis
    apk add --update redis

ADD redis.conf /etc/supervisor/conf.d/redis.conf
