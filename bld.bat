@echo off
set ELECTRON_APP_NAME=MicroDrop
set ELECTRON_PKG_NAME=%ELECTRON_APP_NAME%-win32-ia32
set INSTALL_PATH=%PREFIX%\library/opt/%PKG_NAME%

echo Directory contents...
dir
echo Current working directory: %CD%
echo Source directory: %SRC_DIR%
echo Install path: %INSTALL_PATH%
echo Conda package path: %PKG_NAME%
echo Electron package path: %ELECTRON_PKG_NAME%

cd %SRC_DIR%

REM Install `electron-packager`
cmd /C npm install -g electron-packager lerna npm-check-updates yarn

REM Install app dependencies
cmd /C yarn bootstrap
cmd /C yarn build

REM Build Electron app executable
cd microdrop-builder
cmd /C npm run packager

REM Delete build files that were installed to prefix.
rmdir /S/Q "%PREFIX%/node_modules"
del "%PREFIX%\electron-packager*"
del "%PREFIX%\lerna*"
del "%PREFIX%\ncu*"
del "%PREFIX%\npm-check-updates*"
del "%PREFIX%\yarn*"

REM Copy packaged Electron app contents to Conda environment.
cmd /C robocopy /NFL /NDL /E packager/%ELECTRON_PKG_NAME% "%INSTALL_PATH%"

REM Make link to main executable in `Scripts` directory.
set EXE_PATH=%CONDA_PREFIX%/library/opt/%PKG_NAME%/%ELECTRON_APP_NAME%.exe
set BAT_PATH=%PREFIX%/Scripts/%PKG_NAME%.bat
echo @echo off >> "%BAT_PATH%"
echo "%EXE_PATH%" %* >> "%BAT_PATH%"
