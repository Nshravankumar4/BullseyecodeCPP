@echo off
echo ============================================
echo IPC PROJECT - BULLSEYE COVERAGE BUILD
echo ============================================
echo.

REM 1. SET ENVIRONMENT VARIABLES
REM =============================
set "COVFILE=C:\Users\shravannunsavath\Documents\test.cov"
set "PROJECT_DIR=%~dp0"
set "BUILD_DIR=%PROJECT_DIR%build-coverage"

echo [1/7] Setting up environment...
echo COVFILE: %COVFILE%
echo Project: %PROJECT_DIR%
echo Build: %BUILD_DIR%

REM 2. ADD BULLSEYE TO PATH
REM =======================
set "PATH=C:\Program Files\BullseyeCoverage\bin;%PATH%"

REM 3. ENABLE COVERAGE INSTRUMENTATION
REM ===================================
echo [2/7] Enabling Bullseye coverage...
cov01 -1
if %ERRORLEVEL% neq 0 (
    echo ERROR: Failed to enable Bullseye coverage
    pause
    exit /b 1
)

REM 4. CLEAN PREVIOUS BUILD
REM =======================
echo [3/7] Cleaning previous build...
if exist "%BUILD_DIR%" rmdir /s /q "%BUILD_DIR%"
if exist "%COVFILE%" del "%COVFILE%"

REM 5. CONFIGURE WITH CMAKE
REM =======================
echo [4/7] Configuring with CMake...
cd /d "%PROJECT_DIR%"
cmake -S . -B "%BUILD_DIR%" ^
    -G "Visual Studio 16 2019" ^
    -A x64 ^
    -DENABLE_COVERAGE=ON

if %ERRORLEVEL% neq 0 (
    echo ERROR: CMake configuration failed
    pause
    exit /b 1
)

REM 6. BUILD PROJECT
REM ================
echo [5/7] Building project...
echo This may take a moment. Look for "BullseyeCoverage Compile" messages...
echo.
cmake --build "%BUILD_DIR%" --config Debug

if not exist "%BUILD_DIR%\Debug\IPC.exe" (
    echo ERROR: Build failed - executable not created
    pause
    exit /b 1
)

REM 7. RUN APPLICATION FOR COVERAGE DATA
REM ====================================
echo [6/7] Running application to collect coverage...
echo.
echo INSTRUCTIONS:
echo 1. The IPC application window will open
echo 2. Click both buttons: "Execute Function A" and "Execute Function B"
echo 3. Wait 2-3 seconds
echo 4. Click "Exit Application" or close the window
echo.
pause
echo.

echo Starting application...
"%BUILD_DIR%\Debug\IPC.exe"

REM 8. GENERATE COVERAGE FILE
REM ==========================
echo [7/7] Generating coverage file...
cov01 -0

REM 9. VERIFY RESULTS
REM =================
echo.
echo ============================================
echo RESULTS:
echo ============================================
if exist "%COVFILE%" (
    echo SUCCESS: Coverage file created!
    echo Location: %COVFILE%
    for %%F in ("%COVFILE%") do (
        echo Size: %%~zF bytes
        echo Modified: %%~tF
    )
    echo.
    echo To view coverage report, run:
    echo   "C:\Program Files\BullseyeCoverage\bin\covbrowse.exe" "%COVFILE%"
) else (
    echo ERROR: No coverage file created!
    echo.
    echo Troubleshooting:
    echo 1. Did the application run successfully?
    echo 2. Did you click the buttons in the application?
    echo 3. Check Bullseye installation and license
)

echo.
pause