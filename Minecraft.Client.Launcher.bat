@echo off
title Minecraft Legacy Edition Launcher
color 0A
setlocal EnableDelayedExpansion
set "launcherVersion=1.0"

:: ==========================================
:: CHECK IF Minecraft.Client.exe EXISTS
:: ==========================================
if not exist "%~dp0Minecraft.Client.exe" (
    cls
    echo.
    echo ##################################################
    echo              MINECRAFT NOT FOUND
    echo ##################################################
    echo.
    echo ERROR: Minecraft.Client.exe was not found.
    echo.
    echo How to fix:
    echo  1. Download Minecraft Legacy Edition
    echo  2. Place this launcher in the root folder next to Minecraft.Client.exe
    echo.
    echo Current folder:
    echo %~dp0
    echo.
    pause
    exit
)
:menu
cls
echo.
echo ##################################################
echo              MINECRAFT LEGACY EDITION
echo.
echo                   Launcher v!launcherVersion!
echo ##################################################
echo.
echo   Enter a Username, IP, and Port
echo.
echo   Leave blank to use defaults.
echo.
echo   Update at killo.club/MCLCELauncher
echo.

set "name="
set "ip="
set "port="
set "args="

:: =========================
:: USERNAME
:: =========================
:getName
set /p name=   [Username] : 

:: If blank, skip validation
if "!name!"=="" goto getIP

:: Check for spaces
if not "!name!"=="!name: =!" (
    echo.
    echo ERROR: Name cannot contain spaces.
    echo.
    goto getName
)

:: =========================
:: IP
:: =========================
:getIP
set /p ip=     [Server IP]   : 

:: If blank, skip validation
if "!ip!"=="" goto getPort

set "test=!ip!"
for %%A in (0 1 2 3 4 5 6 7 8 9 .) do set "test=!test:%%A=!"

if not "!test!"=="" (
    echo.
    echo ERROR: IP can only contain numbers and dots.
    echo.
    goto getIP
)

:: =========================
:: PORT
:: =========================
:getPort
set /p port=   [Server Port] : 

:: If blank, continue
if "!port!"=="" goto buildArgs

set "test=!port!"
for %%A in (0 1 2 3 4 5 6 7 8 9) do set "test=!test:%%A=!"

if not "!test!"=="" (
    echo.
    echo ERROR: Port can only contain numbers.
    echo.
    goto getPort
)

:: =========================
:: CONFIRM BUILD ARGS
:: =========================

:buildArgs
if not "!name!"=="" set args=!args! -name !name!
if not "!ip!"=="" set args=!args! -ip !ip!
if not "!port!"=="" set args=!args! -port !port!

echo.
echo ##################################################
echo     Ready to Launch Minecraft Legacy Edition
echo ##################################################
echo.
echo   Minecraft.Client.exe !args!
echo.
choice /c YN /m "Start Minecraft?"
if errorlevel 2 goto end
echo.
echo Launching...
start "" "Minecraft.Client.exe" !args!
:end
endlocal
exit