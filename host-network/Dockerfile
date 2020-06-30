FROM redis

MAINTAINER little-tiger-2006 <admiral.xml@qq.com>

EXPOSE 26379

ADD sentinel.conf /etc/redis/sentinel.conf
RUN chown redis:redis /etc/redis/sentinel.conf

ENV SENTINEL_QUORUM 2
ENV SENTINEL_DOWN_AFTER 30000
ENV SENTINEL_FAILOVER 180000
#makes it easy for users to modify exposed ports from the compose 
ENV SENTINEL_PORT 26379

#addresses for external injection of master, such as Host network mode, require 'localhost'
ENV REDIS_MASTER_ADDRESS redis-master
ENV REDIS_MASTER_PWD ""
ENV REDIS_MASTER_PORT 6379


COPY sentinel-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/sentinel-entrypoint.sh

ENTRYPOINT ["sentinel-entrypoint.sh"]

