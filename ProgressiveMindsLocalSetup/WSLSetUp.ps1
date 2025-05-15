# This script is invoked for setting up WSL on Windows machine.
# It has been tested on Windows 11 Home

# Invoking SetupUtils
. .\SetupUtils.ps1

# Now progress
Write-Log -Message "Checking Execution Policy..." -ModuleName "WSL Pre-Setup"
$executionPolicy = Get-ExecutionPolicy -Scope Process
if ($executionPolicy -eq "Bypass") {
    Write-Log -Message "ExecutionPolicy is already set to Bypass. Skipping..." -ModuleName "WSL Pre-Setup"
}
else {
    Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
    Write-Log -Message "ExecutionPolicy is set to Bypass." -ModuleName "WSL Pre-Setup"
}

# Check if Window's optional WSL Feature is enabled
Write-Log -Message "Starting WSL setup..." -ModuleName "WSL Setup"
Write-Log -Message "Checking if Windows Feature is enabled or not..." -ModuleName "WSL Setup"
$wslFeature = Get-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
if ($wslFeature.State -eq "Enabled") {
    Write-Log -Message "Window's optional WSL Feature is already enabled. Skipping..." -ModuleName "WSL Setup"
}
else {
    Write-Log -Message "Window's optional WSL Feature is not enabled. Enabling WSL..."  -ModuleName "WSL Setup"
    # Enable WSL
    Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux -NoRestart
    dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
    dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
    Write-Log -Message "Window's optional WSL Feature is enabled Successfully..."  -ModuleName "WSL Setup"
}

Write-Log -Message "Script will attempt to create a staging directory and download required softwares to install" "WSL Install"
Write-Log -Message "Checking for staging directory if it does not exists"  "WSL Install"
if (-Not (Test-Path -Path .\staging)) {
    Write-Log -Message "Staging directory does not exists"  "WSL Install"
    $stagingDir = mkdir .\staging
    Write-Log -Message "Created staging directory"  "WSL Install"
}
else {
    Write-Log -Message "Staging directory already exists"  "WSL Install"
}

# Now progressing with Downloading WSL and required distro
Write-Log -Message "Downloading WSL and distro..........!" "WSL Install"
# WSL first
Write-Log -Message "Checking if WSL Executable is already downloaded....."  "WSL Install"
if (Test-Path .\staging\wsl_update_x64.msi) {
    Write-Log -Message "wsl_update_x64.msi exists and skip download stage."  "WSL Install"
}
else {
    Write-Log -Message "wsl_update_x64.msi does not exists, downloading rquired Executable."  "WSL Install"
    curl.exe -L -o .\staging\wsl_update_x64.msi https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi
    Write-Log -Message "wsl_update_x64.msi downloaded Successfully."  "WSL Install"
}

$upgradeUbubtu = Get-UserInput -Prompt "Chimera is looking to develop in Ubuntu 24.04. If you have previously installed Ubuntu 20.04 using Chimera, this script will not touch that previous one. Maintaining your code within GitLab is assumed. Press any button to proceed." -DefaultValue "true"


# Now downloading Ubuntu.
Write-Log -Message "***Ubuntu download happens as application bundle, which needs to be converted to zip***"  "WSL Install"
Write-Log -Message "Checking if ubuntuLTS.appx was downloaded before"  "WSL Install"

$wslName = "chimera-2404"
if (Test-Path .\staging\$wslName.zip) {
    Write-Log -Message "Ubuntu 24.04 appx download already exists. Hence, skipping download stage."  "WSL Install"
}
else {
    Write-Log -Message "Ubuntu 24.04 appx download does not exists, downloading rquired Executable."  "WSL Install"
    curl.exe -L -o .\staging\ubuntuLTS-2404.appx https://wslstorestorage.blob.core.windows.net/wslblob/Ubuntu2404-240425.AppxBundle
    Write-Log -Message "ubuntuLTS-2404.appx downloaded Successfully"  "WSL Install"
    Move-Item .\staging\ubuntuLTS-2404.appx .\staging\$wslName.zip
    Write-Log -Message "ubuntuLTS-2401.appx renamed to $wslName.zip"  "WSL Install"
}

Write-Log -Message "UnCompressing  Ubantu Appx File if required"  "WSL Install"
if (-Not (Test-Path -Path .\staging\$wslName\ubantu\install.tar.gz)) {
    Write-Log -Message "UnCompressing Ubantu Appx File ...."  "WSL Install"
    Expand-Archive .\staging\$wslName.zip .\staging\$wslName
    Rename-Item -Path ".\staging\$wslName\Ubuntu_2404.0.5.0_x64.appx" -NewName "Ubuntu_2404.0.5.0_x64.zip"
    Expand-Archive -Path ".\staging\$wslName\Ubuntu_2404.0.5.0_x64.zip" -DestinationPath ".\staging\$wslName\ubantu"
    Write-Log -Message "Ubuntu_2404.0.5.0_x64.zip is uncompressed to .\staging\$wslName\ubantu...."  "WSL Install"
}
else {
    Write-Log -Message "Ubantu 2404 Appx File is already uncompressed... Ready for installation.."  "WSL Install"
}

# Now progress to install up wsl
# The process is idempotent.
$wslDefaultVersion = (Get-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Lxss" -Name "DefaultVersion" -ErrorAction SilentlyContinue).DefaultVersion
if ($wslDefaultVersion -eq 2) {
    Write-Output "WSL is already installed and default version is set to 2 (WSL 2)." "WSL Install"
}
else {
    Write-Log -Message "Installing WSL Version 2."  "WSL Install"
    .\staging\wsl_update_x64.msi /quiet
    Write-Log -Message "Setting WSL Version 2."  "WSL Install"
    wsl --set-default-version 2
    Write-Output "WSL default version is now set to 2." "WSL Install"

    # TODO: A restart was required
}

Write-Log -Message "Checking if $wslName distro already installed in WSL"  "WSL Ubuntu Install"
$wsl_list = wsl --list
$wslDistroInstalled = $wsl_list -contains $wslName -OR $wsl_list -contains "$wslName (Default)"  

if ($wslDistroInstalled) {
    Write-Log -Message "$wslName Distro (Ubuntu-24.04) already installed in WSL"  "WSL Ubuntu Install"
    $userResponse = Get-BoundedUserInput -Prompt "Do you want to re-install?(Y/y or N/n)." -ValidOptions @("Y", "y", "n", "N") -ModuleName "WSL Ubuntu Install"
    $wslDistroInstalled = $userResponse -ieq "N"

    if (-Not $wslDistroInstalled) {
        Write-Log -Message "Unregistering $wslName Distro (Ubuntu-24.04)"  "WSL Ubuntu Install"
        wsl.exe --unregister $wslName
        Write-Log -Message "Unregister $wslName Distro (Ubuntu-24.04) - Successful"  "WSL Ubuntu Install"
    }
}

if (-Not $wslDistroInstalled) {
    Write-Log -Message "$wslName (Ubuntu-24.04) installation in WSL to progress.."  "WSL Ubuntu Install"

    $wslInstallationPath = Get-UserInput -Prompt "Enter the WSL Installation Path (Default Path : c:/$wslName)" -DefaultValue "c:/$wslName"
    # Ensure that InstallationPath is available
    Write-Log -Message "Creating Installation Path $wslInstallationPath if required"  "WSL Ubuntu Install"
    if (-Not (Test-Path -Path $wslInstallationPath)) {
        mkdir $wslInstallationPath
        Write-Log -Message "Installation Path $wslInstallationPath created"  "WSL Ubuntu Install"
    }
    else {
        Write-Log -Message "Installation Path $wslInstallationPath already exists"  "WSL Ubuntu Install"
    }
    Start-Sleep -Seconds 5
    # Now get other names. I think we should hard code username to ensure that everyone has same name. Let's discuss.
    $username = "chimera"
    Write-Log -Message "WSL Name to Set is $wslName"  "WSL Ubuntu Install"
    Write-Log -Message "WSL Installation Path $wslInstallationPath"  "WSL Ubuntu Install"
    Write-Log -Message "WSL User Name $username"  "WSL Ubuntu Install"

    Write-Log -Message "Importing DistroName: $wslName InstallLocation: $wslInstallationPath using InstallTarFile: .\staging\$wslName\ubantu\install.tar.gz"  "WSL Ubuntu Install"
    wsl --import $wslName $wslInstallationPath .\staging\$wslName\ubantu\install.tar.gz
    Write-Log -Message "WSL Import of $wslName complete"  "WSL Ubuntu Install"

    Start-Sleep -Seconds 5
    # Update the system
    Write-Log -Message "Updating System With Recent Bineries"  "WSL Ubuntu Update"
    wsl -d $wslName -u root bash -ic "apt update; apt upgrade -y"
    
    Start-Sleep -Seconds 5
    Write-Log -Message "create your user and add it to sudoers"  "WSL Ubuntu Update"
    wsl -d $wslName -u root bash -ic "./scripts/config/system/createUser.sh $username ubuntu"

    Write-Log -Message "ensure $wslName is restarted when first used with user account"  "WSL Ubuntu Update"
    wsl -t $wslName
    Write-Log -Message "$wslName is terminated. When you need to use this distro - use 'wsl -d $wslName'"  "WSL Ubuntu Update"

    Write-Log -Message "Installing Base packages upfront"  "WSL Ubuntu Update"
    wsl -d $wslName -u root bash -ic ./scripts/install/installBasePackages.sh
}
