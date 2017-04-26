@FOR /f "tokens=*" %%i IN ('docker-machine env --shell cmd') DO @%%i
cd..
docker run -it --name meteordb --hostname meteordb meteor:db
pause
