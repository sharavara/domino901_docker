#!/bin/bash

#start web server for static content
docker run --name software -p 7777:80 -v /home/vs/software:/usr/share/nginx/html:ro -d nginx
