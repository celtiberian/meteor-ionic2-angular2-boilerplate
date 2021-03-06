@FOR /f "tokens=*" %%i IN ('docker-machine env --shell cmd') DO @%%i

cd..
rmdir /S /Q node_modules
rmdir /S /Q .meteor\local
rmdir /S /Q .build
cmd /C npm install --production
mkdir .build
cmd /C meteor build --directory .build --architecture os.linux.x86_64

docker build -f docker/dockerfile.app -t meteor:app .
docker build -f docker/dockerfile.db -t meteor:db .
pause
