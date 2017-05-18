## Production Docker Deployment
- Install [Docker Toolbox](https://docs.docker.com/toolbox/overview/)
- Open Docker QuickStart Terminal. The docker image should be built without errors. Close it afterwards.
- if docker is not running: `docker-machine start default`
- `cd <project>/docker`
- `build_images.bat` or `build_images.sh`
- `launch_db.bat` or `launch_db.sh`
- `launch_app.bat` or `launch_app.sh`

## Docker Cheat Sheet

- Share volumes in Windows outside c:\Users:
`"%VBOX_MSI_INSTALL_PATH%\VBoxManage.exe" sharedfolder add default --name "<src>" --hostpath "c:\"` - this will enable the `-v`option to mount volumes using any directory under `C:\`
- Set/Update CMD docker environment variables (Windows): `@FOR /f "tokens=*" %i IN ('docker-machine env --shell cmd') DO @%i`
- Set/Update BASH environment variables (Mac): `eval $(docker-machine env default)`
- get the IP of the docker machine: `docker-machine ip default`
- to get a bash in a container with user root: `docker exec -u root -it "id of running container" bash`
- list all containers: `docker ps -a`
- list all images: `docker images`
- remove all containers (in Windows use Docker Terminal): `docker rm $(docker ps –a -q)`
- remove all images (in Windows use Docker Terminal): `docker rmi $(docker images -q)`
- remove only dangling images (in Windows use Docker Terminal): `docker rmi $(docker images -qf "dangling=true")`
- remove all unused (exited) containers: `docker container prune`
- build with tag and name: `docker build -t meteor:base -n meteorbase -f docker/Dockerfile.base .`
- run container, removing it when finished, and converting port 80 in the container to port 8080 in the docker machine: `docker run --rm -it -p 80:8080 meteorapp:build`
- get the internal IP of all containers: `docker network inspect bridge`
