# docker-vernemq
Dockerfile for packaging [VerneMQ](https://verne.mq/) from **Ubuntu14.04**.

## Instructions to build docker image

### Clone source code

`git clone https://github.com/jonascheng/docker-vernemq.git`

### Prepare Docker Engine by following [docker docs](https://docs.docker.com/engine/installation/ubuntulinux/).

* Add the new gpg key.

`sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D`

* Create docker.list file, and add the following entry.

`sudo touch /etc/apt/sources.list.d/docker.list` 

> #### deb https://apt.dockerproject.org/repo ubuntu-trusty main

* Update the apt package index.

`sudo apt-get update`

* Install Docker.

`sudo apt-get install docker-engine`

* Start the docker daemon.

`sudo service docker start`

* Verify docker is installed correctly.

`sudo docker run hello-world`

### Build your own image

`sudo docker build -t docker-vernemq .`

Don't miss the last '.' in command line.

## Instructions to start container

### Start container

`sudo docker run -d -v [Path to configuration]:/host --name [Name to the Container] docker-vernemq`

> * [Path to configuration], please specify the location where contains vernemq.conf.default, vmq.acl.default, and vmq.passwd.default. 

## Instructions to login container

### Login container

`sudo docker exec -ti [Container ID] bash`

## Instructions to cluster containers

If you'd like to clustering VerneMQ, I've created two sample set of configuration files under .\clustering. The example beneth assumes docker netowrk assigning 172.17.0.2 and 172.17.0.3 to containers respectively.

### Start container broker1

`sudo docker run -d -v [Path to broker1 configuration]:/host --add-host=mqtt1.trendmicro.com:172.17.0.2 --add-host=mqtt2.trendmicro.com:172.17.0.3 --name broker1 docker-vernemq`

### Start container broker2

`sudo docker run -d -v [Path to broker2 configuration]:/host --add-host=mqtt1.trendmicro.com:172.17.0.2 --add-host=mqtt2.trendmicro.com:172.17.0.3 --name broker2 docker-vernemq`

### Login broker2

`sudo docker exec -ti [Broker2 container ID] bash`

### Join broker2 to broker1

`vmq-admin cluster join discovery-node=broker1@mqtt1.trendmicro.com`

> ### Trick to make clutering works
> **listener.vmq.clustering = 172.17.0.2:44053**
>
> Message is not forwarding to other node when run two nodes in virtual machine, don't bind to 0.0.0.0.
> Bind to 0.0.0.0 may cause node connecting failure. [Ref](https://github.com/erlio/vernemq/issues/32)
> 
> **nodename = broker1@mqtt1.trendmicro.com**
> 
> It is important to choose proper VerneMQ node names. In vernemq.conf change the nodename = VerneMQ@127.0.0.1 to something appropriate. Make sure that the node names are unique within the cluster.
> The hostname after '@' should be resolvable in etc/hosts as well.

## References

* [VerneMQ](https://verne.mq/)
* [Docker Docs](https://docs.docker.com/)
* [VerneMQ Clustering](https://verne.mq/docs/clustering.html)


