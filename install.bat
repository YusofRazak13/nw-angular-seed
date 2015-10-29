@ECHO OFF
SET VER=0.12.2
SET LIBHOST=http://192.168.0.197/nwng-libs/
IF NOT EXIST C:\Downloads (
  mkdir C:\Downloads
)
SET DOWNLOADEDFILE=%TEMP%\nwjs-v%VER%-win-ia32.zip
SET DOWNLOADLINK=http://dl.nwjs.io/v%VER%/nwjs-v%VER%-win-ia32.zip
IF NOT EXIST %DOWNLOADEDFILE% (
  ECHO "Downloading NW.js Package..."
  START /WAIT _redist\wget\wget.exe %DOWNLOADLINK% -O %DOWNLOADEDFILE%
)
ECHO "Extracting NW.js..."
START /WAIT _redist\7zip\7za.exe e %DOWNLOADEDFILE% -y -o.\
IF NOT EXIST locales (
  mkdir locales
)

MOVE *.pak locales\
MOVE locales\nw.pak .\

REM BEGIN DEPENDENCY INJECTION REM
REM
REM ffmpegsumo.dll
SET LIBNAME=ffmpegsumo
IF NOT EXIST ffmpegsumo.dll (
  START /WAIT _redist\wget\wget.exe  %LIBHOST%/%LIBNAME%.dll.zip -O %TEMP%\%LIBNAME%.dll.zip
  START /WAIT _redist\7zip\7za.exe e %TEMP%\%LIBNAME%.dll.zip -y -o.\
  DEL %TEMP\%LIBNAME%.zip
)

REM npWebChimera.dll
SET LIBNAME=npWebChimera
IF NOT EXIST .\plugins\npWebChimera.dll (
  IF NOT EXIST .\plugins MKDIR .\plugins
  START /WAIT _redist\wget\wget.exe  %LIBHOST%/%LIBNAME%.dll.zip -O %TEMP%\%LIBNAME%.dll.zip
  START /WAIT _redist\7zip\7za.exe e %TEMP%\%LIBNAME%.dll.zip -y -o.\plugins
  DEL %TEMP\%LIBNAME%.zip
)
REM
REM END DEPENDENCY INJECTION REM

IF EXIST .\node_modules.zip (
  ECHO "Node Modules found! Extracting node_modules..."
  IF NOT EXIST .\node_modules MKDIR node_modules
  START /WAIT _redist\7zip\7za.exe x node_modules.zip -y -o.\node_modules
)

ECHO "Complete!"
PAUSE
