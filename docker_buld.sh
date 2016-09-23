#Docker buid image IBM Domino 9.0.1
docker build -t vs/domino:9.0.1 -f Dockerfile_domino901_ubuntu.txt .
docker run -it --name domino901 vs/domino:9.0.1


#Docker buid image IBM Domino 9.0.1 FP7
docker build -t vs/domino:9.0.1-fp7 -f Dockerfile_domino901_fp7_ubuntu.txt .
docker run -it --name domino_fp7 vs/domino:9.0.1-fp7


#Docker buid production image of IBM Domino 9.0.1 FP7 server
docker build -t vs/domino_dev -f Dockerfile_domino_setup.txt .


#Run container for the image "vs/domino_dev"
docker volume create --name=domino-dev
docker run -it -p 8585:8585 -p 1352:1352 -p 8888:80 -p 8443:443 --name domino_dev -v domino-dev:/lacal/notesdata vs/domino_dev
docker start domino_dev


#delete container & volume
docker rm domino_dev
docker rmi vs/domino_dev
docker volume rm domino-dev
