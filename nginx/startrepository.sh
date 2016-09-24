#!/bin/bash

#start web server for static content
docker run --name software -v -p 7777:80 /home/vs/software:/usr/share/nginx/html:ro -d nginx

docker build -t vv/domino:9.0.1 .
docker build -t vv/domino:9.0.1-fp7 .
docker build -t vv/domino:9.0.1fp7 .


docker run -it --name domino_fp7 vv/domino:9.0.1-fp

docker run -it --name domino vv/domino:9.0.1

#calculate folder size
du -s *|sort -nr|cut -f 2-|while read a;do du -hs $a;done

/opt/ibm/domino/notes/90010/linux/data1_bck = 244M
