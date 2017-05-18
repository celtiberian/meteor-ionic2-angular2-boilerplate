cd ..
rmdir /S /Q node_modules
rmdir /S /Q .meteor\local
rmdir /S /Q .build
cmd /C npm install --production
mkdir .build
cmd /C meteor build --directory .build --architecture os.linux.x86_64
pause
