@FOR /f "tokens=*" %%i IN ('docker-machine env --shell cmd') DO @%%i
cd..
docker run --rm -it --name meteorapp --hostname meteorapp --link meteordb:meteordb ^
	-e PORT=3000 ^
	-e ROOT_URL=http://site.com ^
	-e MONGO_URL=mongodb://meteordb:27017/db ^
	-e MONGO_OPLOG_URL=mongodb://oplogger:oplogger@meteordb:27017/local?authSource=admin ^
	-p 3000:3000 ^
	meteor:app
pause
