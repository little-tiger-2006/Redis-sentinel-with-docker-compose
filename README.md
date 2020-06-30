# Redis-sentinel-with-docker-compose

The implementation code for deploying the Redis and Sentinel cluster in the "Host Mode" has been added here, and the Redis master and Sentinel ENV settings are also provided.

Redis-sentinel ha deploy using docker-compose with `host mode` & `bridge mode`, the example deploy the basic model: 1 master, 2 slave, 3 sentinel  


![这里随便写文字](https://imgkr.cn-bj.ufileos.com/6145772a-0cfd-4760-8edf-450d2f1bd405.png)



## ideas
Complete the deployment of redis and sentinel in a compose file.

The example show the redis container mapping 6380、6381、6382、26380、26381、26382 port

Verify that the cluster is in effect by following the 2 steps:
1. Connect to redis master instance ,enter 'info replication', we should be able to see the words `connected_slaves: 2`.
2. Connect to any of the Sentinel instances,enter 'sentinel master mymaster', go to line 9 & 31 & 33.
   flags: master indicates master operation, abnormal conditions show s-down, o-down.  (line 9 & 10)
   num-slaves: detected 2 Slave replica sets. (line 31 & 32)
   num-other-sentinels: In addition, there are 2 sentinels. (line 33 & 34).
   
## tip
1. when redis redis app deploy independence machine， please config the ENV (`REDIS_MASTER_ADDRESS`,`REDIS_MASTER_PORT`) with the  machine ip & bind port.
2. if you using `requirepass` set the client access pwd, please ensure usinng the `masterauth` set the replicas replication pwd
3. In the docker-copose.yml, if you have set the 'requirepass' for  the master, please set the `REDIS_MASTER_PWD` for the master,
   because the master will become a slvae when failover，then it is also need a masterauth
