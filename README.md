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

`sudo docker run -d -v [Path to this folder]:/host -p [Host IP]:1883:1883 --name [Name to the Container] docker-vernemq`

> * [Path to this folder], please specify the location where contains vernemq.conf.default, vmq.acl.default, and vmq.passwd.default.
> * [Host IP], please specify the external IP which binds to 

## References
* [VerneMQ](https://verne.mq/)
* [Docker Docs](https://docs.docker.com/)

