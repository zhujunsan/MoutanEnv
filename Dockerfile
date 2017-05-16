FROM zhujunsan/lnp:latest

MAINTAINER San <zhujunsan@gmail.com>

ENV THRIFT_VERSION 0.10.0

# Install Redis
RUN apk add --update --no-cache redis

# Install Node.js
RUN apk add --update --no-cache nodejs

# Install Thrift
RUN apk add --update --no-cache gcc g++ make automake autoconf bison flex && \
    curl -fSL http://mirror.cc.columbia.edu/pub/software/apache/thrift/$THRIFT_VERSION/thrift-$THRIFT_VERSION.tar.gz -o thrift.tar.gz && \
    tar -zxC /usr/src -f thrift.tar.gz && \
    rm thrift.tar.gz && \
    cd /usr/src/thrift-$THRIFT_VERSION && \
    ./configure --without-python --without-nodejs && \
    make -j4 && \
    make install && \
    rm -rf /usr/src/thrift-$THRIFT_VERSION && \
    apk del --purge gcc g++ make automake autoconf bison flex

ADD redis.conf /etc/supervisor/conf.d/redis.conf

RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone
