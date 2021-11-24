@ECHO OFF

Rem Get name of folder program is running in
set MYDIR=%~dp0
set MYDIR1=%MYDIR:~0,-1%

for %%f in (%MYDIR1%) do set myfolder=%%~nxf

echo.
echo Removing old container:

echo - Stopping old container...
docker stop %myfolder%
echo - Removing old container...
docker rm %myfolder%


echo.
echo Creating volume %myfolder%_vol:

if not exist "c:\data\%myfolder%" (
    echo - Creating folder...
    mkdir c:\data\%myfolder%
)

if not exist "c:\data\%myfolder%\home.txt" (
    echo - Creating file...
    break>"c:\data\%myfolder%\home.txt"
)

echo - Creating volume...
docker volume create %myfolder%_vol

echo.
echo Running %myfolder% in new container:

echo - Running container...
docker run -p 8080:8080 --name=%myfolder% -v c:\data\%myfolder%:/data %myfolder%

PAUSE