---
layout: post
title: Docker Hexo and Httpd Webserver
date: 2023-06-29 02:30:23
tags:
- Technology
- Tutorial
- Docker
- Hexo
- Advance
cover: /images/asset/kankuu-h2d.png
---
![](/images/asset/kankuu-h2d.png)
Yo, wasup ? _Dockerize your Hexo Blog_ :> ehehe
ever you _develop_ [hexo](https://hexo.io) on container before? of course without `node` environment on your local machine, coz we'll use `docker` instead :>

> ### The purpose of this Post you'll learn
- what is `hexo`
- what is `httpd`
- how to make docker hexo `images`
- how to develop hexo with `docker`
- how to take advantage on `httpd` webserver

## Introduction
Fist we need to know what is `hexo` and `httpd` :> okay, lemme introduce you..
Hexo is A fast, simple & powerful blog framework, they write with [markdown](https://en.wikipedia.org/wiki/Markdown) syntax, and you know what this website is create with `hexo` too :> the point is hexo convert _markdown_ to _static_ web.

Then what is `httpd` ? httpd is __HyperText Transfer Protocol Daemon__ like `apache2` webserver, somehow they call it __http daemon__ that server our website like an apache webserver. so what different between of `httpd` and __apache2__ webserver ? i think they two of same function but for i know, the memory of httpd is savemore than apache2 :> 

### Building Hexo Images
as usually or by basically environment to develop hexo is `NodeJS` and **NPM** and then we must install _hexo-cli_ to create initial our hexo right? then how'd we develop hexo without any environment of node ? let begin with building `hexo-docker-image` :> first we must create `Dockerfile`

> NOTE
if you haven't understand what is go [here](https://kankuu.web.id/2019/02/16/003-Apa-Itu-Docker-and-Basic-Dockerize/)


------- create file named : `Dockerfile`, the Dockerfile will be like bellow
```Dockerfile
#
# Hexo Dockerfile
#
# https://github.com/billryan/docker-hexo
#

# Pull base image.
FROM node:slim
LABEL your_username <your@email.com>

RUN useradd hexo
WORKDIR /home/hexo

RUN chown -R hexo:hexo /home/hexo
RUN npm install hexo-cli -g

USER hexo
```
first i'll give you some knowledge about those above, node has images with tag slim, why we use that ? i affirm you all this is option, if you won't to build images you can just pull mine :> `kankuu/hexo:lastest`,. those Dockerfile will build an images with pull __from__ node images and get tag name by `slime`, the builded images will labeled by __yourname <your@email.com>__, while proccess building `RUN` command will be execute __useradd hexo__ and create wokring directory by `WORKDIR` on path __/home/hexo__. Some common configuration with execution __chown -R hexo:hexo /home/hexo__ while make directory hexo on `/home` while be changed owner by user **hexo**, then for final configuration is installing __hexo-cli__ for common usage by **global** parameter. the meaning of `USER` hexo is when we executing command on container that was running UP, that command will be execute by user `hexo`.

> #### Stay Tune, this Post is still in Progress... :>