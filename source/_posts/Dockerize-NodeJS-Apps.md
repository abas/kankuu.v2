---
layout: post
title: 'Dockerize NodeJS Apps'
date: 2019-01-30 02:08:25
tags: 
- Technology
- Tutorial
- Developer
- Docker
- NodeJS
cover: /images/asset/docker-nodejs.png
---
![](/images/asset/docker-nodejs.png)
# Docker NodeJS | Express sample
Dockerize your nodeapps project :>
some environment may using node include npm pm2 etc. but now we can just deploy it with `docker`:[reference](https://docs.docker.com) :>

> ### The purpose of this Post you will learn 
- how to use `nodejs` with `Docker`
- building base nodejs `images`
- configure `docker-compose` stack
- running `nodejs` apps with docker

on usually.. some basic nodejs project like an express is default serve `index.js` but some other remake that with own their like, so we can assume that is simple diffrent. You may can understand if you try documentation of [express](https://expressjs.com) and may other framework look like.

## Creating New NodeJS Project 
simply,. the host with node/npm binary or we can just call it node and npm installed, can create project by command `npm init -y`. so how docker can create project by the way? :> do not confuse with small thing like that :v docker also have their way to create project with no environment installed on their host. if on host env we can just run `npm init -y` also docker have a way to do that. but first we must build own `docker images` :> 

> Project Structure will be

```txt
.../service
  ../
  |- simple-apps/
    | node_modules/
    |- package.json
    |- index.js
    .
    |- etc
    .
  |- Dockerfile
  |- docker-compose.yml
  .
  .
  |- etc
...
```

### Build Images
we can pull existing images from [dockerhub](https://hub.docker.com) and modify that, so we can use our image according to the needs.
the `Dockerfile` will be look like bellow
```Dockerfile
FROM node:8

LABEL kankuu <akhmadbasir5@gmail.com>

RUN echo "|----> updating repository" \
  && apt-get update -y \
  && echo "|----> successfull update" \
  || echo "|----> failed to update"

RUN echo "|----> installing tool" \
  && apt-get install -y \
  # add tool here
  nano \
  && echo "|----> successfull installing tool" \
  || echo "|----> failed to install tool"

RUN mkdir /app
WORKDIR /app

EXPOSE 3000
```

> Building Images

```bash
  # basic
  $ docker build -f /path/to/Dockerfile -t username/images:tag .

  # assume we can define
  # username : kankuu
  # images : nodeapps
  # tag : dev
  # so the command should be like this
  $ docker build -f Dockerfile -t kankuu/nodeapps:dev .
```
now we have new images called `kankuu/nodeapps` with tag name `dev`, you can push images to dockerhub or just save to your local machine :>
i am prefer to push that image, because if we lost our images we can just pull it again :> happy pulling images :>

> Creating Project

we have images, and we have access local to use that. so on other way to make new project we can use command bellow.
```bash
  $ mkdir sample-apps && cd sample-apps
  $ docker run -ti --rm -v $(pwd)/:/app kankuu/nodeapps:dev npm init -y

  # then to installing package node
  $ docker run -ti --rm -v $(pwd)/:/app kankuu/nodeapps:dev npm install
```
how about if you have existing project? :> dont worry my brother :> let sing and song :> ehehe :D \*sorry
if you have an existing project and want to install package, just run command bellow.
```bash
  $ docker run -ti --rm -v $(/path/to/project):/app kankuu/nodeapps:dev npm install
  # then see your project, new folder created there :> `node_modules`
```

## Deploy NodeJS Apps
Basically `nodejs` has a tool or library to deploy by simple usage, they call it [`pm2`](http://pm2.io) NodeJS __Production Proccess Manager__. this library can help us to deploy by easy way.. just with single command `pm2 start index.js` and everything gonna __blow up__, but of course we must have node and npm environment installed on our host. so whatever if you want to use pm2 you can use it by your way. `But`(t) we have **docker** here :> why dont we use that? ehehe

Okay, lets Rock with docker and how to deploy it.. *NodeJS APP.
there are many way to deploy Our NodeJS Apps with docker, but in this way... i just tell you to use 2 ways is enough, first we'll deploy it with `single docker command` and second is we use `docker-compose` stack. in any case this two way is not different too much, as a sample :

> Differently __Docker__ & **Docker-Compose**

\# Docker single Command
```bash
  $ docker run -d --name sample_name --restart always --port 80:80 sample_images:sample_tag
```

so the `docker-compose` will be like this

\# Docker-Compose
```yml
version: "3"
services:
  service_name:
    container_name: sample_name
    restart: always
    ports: 
      - 80:80
      # if there any port to expose, add another line. sample: *just uncomment bellow
      # - 443:443
    # etc
```
then if anything done, you can run it by `docker-compose -f /path/to/docker-compose.yml up -d`, and `docker ps -a` to check it :>
the compose will create a container with name `sample_name` and port exposed will be `80:80`.. is there status is UP, that mean container is running well, is Exited. ouch, may you can check the logs by `docker-compose logs` :> any case of confuse thing? :> 

and then what ? :v ehehe, oke now you understand different between `docker` and `docker-compose` by basically, Ok. starting to deploy our NodeJS Apps. **Remember** Basic Structure of the project ? in the root of sample `service` we can call it __node-service__, there are 3 things to understand basic service. Dockerfile, docker-compose.yml, Sample-Apps :> understood? hopely you'd.

> Deploy NodeJS Apps with `docker` sing command line

\# if you has an __existing__ project, their must be `index.js` inside, right? if you have a node env, you can run it by command `node index.js` then service must be up there. same as docker usage..
```bash
  $ docker run -d \
      --name node-app \
      -v /path/to/root/project:/app \
      --restart always \
      -p 80:3000 \
      kankuu/nodeapps:dev \
      npm start
```
if you want to specified network use `--net [network_name]` instead. `-d` mean they will running under forground, and `npm start` is command to run service, this depend on whats you was defined, see your `package.json` file, is there no defined yet use `node file.js` instead :> almost done.

> Deploy NodeJS Apps with `docker-compose` stack

\# like i was talking before.. docker-compose just little different with docker single command, but in this case we need to install docker-compose, see [here](https://github.com/abas/docker-install ) to install docker-compose. and if you done yet of installing docker-compose. now we can start with creating `docker-compose.yml` file :> the structure of `docker-compose.yml` is like bellow.
```yml
version: "3" # use latest version
services: # from here we'll define all the service
  service_name: # this will be the name of service, and can be hostname of service
    image: username/image:tag # you can define images by yours
    container_name: service_name # i prefer to named look like service_name, so we do not confuse next time
    ports:
      - 80:3000
      - 443:4433 # if you dont have SSL yet, you can comment this section
    volumes:
      - /path/on/host:/path/on/container
    command: "npm start"
```
when everything is done, `docker-compose up -d` to deploy it and make service UP. also you can check the containers with `docker-compose ps` and is there any error or status didnt work correctly you can check it with `docker-compose logs` :> see ? now you can think about your opinion, you can deploy it with `single docker command` or `docker-compose` better or not is up to you.. but i prefer to make `docker-compose.yml` file cause if you want to deploy other service you can just clone it.. remake the compose and deploy it again as you want. dont forget to see [documentation](https://docs.docker.com/compose/reference/overview/) :>

Ok. see you next time :> if you have a lot of __question__ you can contact me :> 
the link in right corner below :> thankyou~