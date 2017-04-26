@FOR /f "tokens=*" %%i IN ('docker-machine env --shell cmd') DO @%%i
cd..
docker build -f docker/dockerfile.base -t meteor:base .
docker build -f docker/dockerfile.app -t meteor:app .
docker build -f docker/dockerfile.db -t meteor:db .
pause
