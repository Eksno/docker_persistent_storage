@ECHO OFF

Rem Get name of folder program is running in
set MYDIR=%~dp0
set MYDIR1=%MYDIR:~0,-1%

for %%f in (%MYDIR1%) do set myfolder=%%~nxf

echo Removing old container.
docker stop %myfolder%
docker rm %myfolder%

echo Create volume
docker volume create %myfolder%_vol

echo Running %myfolder% in new container.
docker run -d -p 8080:8080 --name=%myfolder% -v %myfolder%_vol:/data/storage %myfolder%

PAUSE