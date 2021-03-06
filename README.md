# Redis-sentinel-with-docker-compose

The implementation code for deploying the Redis and Sentinel cluster in the "Host Mode" has been added here, and the Redis master and Sentinel ENV settings are also provided.

Redis-sentinel ha deploy using docker-compose with `host mode` & `bridge mode`, the example deploy the basic model: 1 master, 2 slave, 3 sentinel  


![这里随便写文字](https://imgkr.cn-bj.ufileos.com/6145772a-0cfd-4760-8edf-450d2f1bd405.png)



## ideas
Complete the deployment of redis and sentinel in a compose file.

The example show the redis container mapping 6380、6381、6382、26380、26381、26379 port

Verify that the cluster is in effect by following the 3 steps:
<ul>
<li>1. Connect to redis master instance ,enter 'info replication', we should be able to see the words `'connected_slaves: 2'`.</li>
<li>2. Connect to any of the Sentinel instances,enter 'sentinel master mymaster'，find the content in the line below：.</li>
<ul>
<li> line  9 & 10. flags: master, indicates master operation, abnormal conditions show s-down, o-down.</li>
<li> line 31 & 32. num-slaves:2 , detected 2 Slave replica sets.</li>
<li> line 33 & 34. num-other-sentinels:2, in addition there are 2 sentinels.</li>
</ul></li>
<li>3.run the test.sh ，to test the effect of clust.</li>
</ul>

## tip
1. when redis redis app deploy independence machine， please config the ENV (`REDIS_MASTER_ADDRESS`,`REDIS_MASTER_PORT`) with the  machine ip & bind port.
2. if you using `requirepass` set the client access pwd, please ensure usinng the `masterauth` set the replicas replication pwd
3. In the docker-copose.yml, if you have set the 'requirepass' for  the master, please set the `REDIS_MASTER_PWD` for the master,
   because the master will become a slvae when failover，then it is also need a masterauth
4. if you are concerned about the number of imageissues, you can use the 'docker build -t sentinel:latest ./sentinel' to build the common sentinel image, and then replace the 'build: ./sentinel' in the docker-compose.yml with 'image: sentinel'.
