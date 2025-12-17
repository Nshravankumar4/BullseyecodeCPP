@echo off
echo ============================================
echo QT CREATOR LAUNCHER FOR COVERAGE BUILDS
echo ============================================
echo.

REM Set environment for Qt Creator
set "COVFILE=C:\Users\shravannunsavath\Documents\test.cov"
set "PATH=C:\Program Files\BullseyeCoverage\bin;%PATH%"

echo 1. Enabling Bullseye coverage...
cov01 -1

echo.
echo 2. Environment set for coverage builds:
echo    - COVFILE: %COVFILE%
echo    - Bullseye added to PATH
echo.
echo 3. Starting Qt Creator...
echo.
echo IMPORTANT: In Qt Creator:
echo   1. Select kit with ENABLE_COVERAGE=ON
echo   2. Clean project (Build > Clean All)
echo   3. Rebuild project
echo   4. Run application
echo   5. Return here and press any key...
echo.

REM Launch Qt Creator
start "" "C:\Qt\Tools\QtCreator\bin\qtcreator.exe"

pause

echo.
echo 4. Generating coverage file...
cov01 -0

if exist "%COVFILE%" (
    echo Coverage file: %COVFILE%
) else (
    echo No coverage file created
)

pause