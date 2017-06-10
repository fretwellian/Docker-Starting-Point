# Docker Starting point

For a quick and simple starting point to get going with a docker environment.

One container running MySQL and the other Ubuntu 14.04 with the following (nginx, php7.1 - plus the usual guff)

#### Install tips
1. Get [Docker for Mac](https://docs.docker.com/docker-for-mac/install/)
2. Download this repository.
3. Adjust the files (see below).
4. In a terminal go to this folder and run `sh run_build.sh`. This builds the webserver container.
5. Then run `sh run_development.sh` this gets the docker-compose going, 

#### Things to change
1. The filename of the file within the docker/nginx directory and also line 26
2. Then the reference to the above in the Dockerfile
3. docker-compose.yml the image name and network name
4. The the refernce to the image in the run_build.sh
