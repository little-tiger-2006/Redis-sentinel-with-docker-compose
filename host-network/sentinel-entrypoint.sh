#!/bin/sh
#maintainer

sed -i "s/\$SENTINEL_QUORUM/$SENTINEL_QUORUM/g" /etc/redis/sentinel.conf
sed -i "s/\$SENTINEL_DOWN_AFTER/$SENTINEL_DOWN_AFTER/g" /etc/redis/sentinel.conf
sed -i "s/\$SENTINEL_FAILOVER/$SENTINEL_FAILOVER/g" /etc/redis/sentinel.conf

#makes it easy for users to modify exposed ports from the compose 
sed -i "s/\$SENTINEL_PORT/$SENTINEL_PORT/g" /etc/redis/sentinel.conf

#addresses for external injection of master, such as Host network mode, require 'localhost'
sed -i "s/\$REDIS_MASTER_ADDRESS/$REDIS_MASTER_ADDRESS/g" /etc/redis/sentinel.conf
sed -i "s/\$REDIS_MASTER_PORT/$REDIS_MASTER_PORT/g" /etc/redis/sentinel.conf
sed -i "s/\$REDIS_MASTER_PWD/$REDIS_MASTER_PWD/g" /etc/redis/sentinel.conf

exec docker-entrypoint.sh redis-server /etc/redis/sentinel.conf --sentinel
