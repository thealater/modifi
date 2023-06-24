# Check if WinGet is available
try {
    winget --version | Out-Null
} catch {
    Write-Host "WinGet is not available. Attempting to register WinGet..."
    Add-AppxPackage -RegisterByFamilyName -MainPackage "Microsoft.DesktopAppInstaller_8wekyb3d8bbwe"

    # Verify WinGet installation
    try {
        winget --version | Out-Null
    } catch {
        Write-Host "WinGet registration failed. Please ensure you are running Windows 10 1709 (build 16299) or later."
        Write-Host "You can manually install the required dependencies by following the instructions below."
        Write-Host "1. Install the latest version of Node.js from the official Node.js website."
        Write-Host "2. After installing Node.js, open a command prompt or terminal."
        Write-Host "3. Navigate to the launcher directory using the 'cd' command. Example: cd path\to\launcher"
        Write-Host "4. Run the command 'npm i' to install the Node dependencies."
        exit
    }
}

# Install Node.js
Write-Host "Installing Node.js..."
winget install -e --id OpenJS.NodeJS --accept-package-agreements --accept-source-agreements

# Get the directory of the current script
$scriptDir = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent

$launcherDir = Join-Path -Path $scriptDir -ChildPath "..\launcher"

# Switch to the launcher directory
Set-Location -Path $launcherDir

# Run npm install
Write-Host "Installing Node dependencies..."
npm i
