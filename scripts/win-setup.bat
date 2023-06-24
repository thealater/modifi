rem Windows setup script

echo Checking if WinGet is available...
winget --version > nul 2>&1
if %errorlevel% neq 0 (
    echo WinGet is not available. Attempting to register WinGet...
    PowerShell -Command "Add-AppxPackage -RegisterByFamilyName -MainPackage Microsoft.DesktopAppInstaller_8wekyb3d8bbwe"
    
    echo Verifying WinGet installation...
    winget --version > nul 2>&1
    if %errorlevel% neq 0 (
        echo WinGet registration failed. Please ensure you are running Windows 10 1709 (build 16299) or later.
        echo You can manually install the required dependencies by following the instructions below.
        echo.
        echo 1. Install the latest version of Node.js from the official Node.js website.
        echo 2. After installing Node.js, open a command prompt or terminal.
        echo 3. Navigate to the launcher directory using the "cd" command. Example: cd path\to\launcher
        echo 4. Run the command "npm i" to install the Node dependencies.
        pause
        exit /b
    )
)

echo Installing Node.js...
start winget install -e --id OpenJS.NodeJS --accept-package-agreements --accept-source-agreements

REM Get the directory of the current script
for %%I in ("%~dp0") do set "SCRIPT_DIR=%%~dpI"

set "LAUNCHER_DIR=%SCRIPT_DIR%..\launcher"

REM Switch to the launcher directory
cd /d "%LAUNCHER_DIR%"

REM Run npm install
echo Installing Node dependencies...
npm i
