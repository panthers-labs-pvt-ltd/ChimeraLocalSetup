. .\SetupUtils.ps1

$banner = @"
  ___                             _           __  __ _         _ 
 | _ \_ _ ___  __ _ _ _ ___ _____(_)_ _____  |  \/  (_)_ _  __| |
 |  _/ '_/ _ \/ _` | '_/ -_|_-<_-< \ V / -_)  | |\/| | | ' \/ _` |
 |_| |_| \___/\__, |_| \___/__/__/_|\_/\___| |_|  |_|_|_||_\__,_|
              |___/__ _    _                                     
                 / __| |_ (_)_ __  ___ _ _ __ _                  
                | (__| ' \| | '  \/ -_) '_/ _` |                 
                 \___|_||_|_|_|_|_\___|_| \__,_|                 
                                                                 
"@

Write-Host $banner

.\WSLSetUp.ps1

$wslName = "chimera-2404"
$username = "chimera"

Write-Log -Message "Installing Source Code and Softwares"  "Developer Environment Set up"

$sourCodeSetup = Get-UserInput -Prompt "Do you want to set up your source code? If you have setup once, DO NOT setup again. The code is not idempotent yet. (Default will be true)" -DefaultValue "true"
Write-Log -Message "Source Code Setup $sourCodeSetup"  "Source Code Setup"
if ($sourCodeSetup -ieq $true) {
    wsl -d $wslName -u root bash -ic "./scripts/config/system/sudoNoPasswd.sh $username"
    Write-Log -Message "sudoNoPasswd.sh called and completed"  "Source Code Setup"
    wsl -d $wslName -u $username bash -ic ./scripts/install/code_setup.sh
    Write-Log -Message "Source Code setup complete"  "Source Code Setup"
    wsl -d $wslName -u root bash -ic "./scripts/config/system/sudoWithPasswd.sh $username"
}

$installAllSoftware = Get-UserInput -Prompt "Do you want to install full Softwares (Default Will be true)" -DefaultValue "true"
Write-Log -Message "WSL Software Install $installAllSoftware"  "Developer Packages Install"
if ($installAllSoftware -ieq $true) {
    wsl -d $wslName -u root bash -ic "./scripts/config/system/sudoNoPasswd.sh $username"
    Write-Log -Message "sudoNoPasswd.sh called and completed"  "Developer Packages Install"
    wsl -d $wslName -u $username bash -ic ./scripts/install/installAllSoftware.sh
    Write-Log -Message "All installation complete"  "Developer Packages Install"
    wsl -d $wslName -u root bash -ic "./scripts/config/system/sudoWithPasswd.sh $username"
}

# Setting up Path for User Environment
# To be corrected.
<# $userEnvPath = [System.Environment]::GetEnvironmentVariable("Path", "User")
$pathToUbuntu = Join-Path -Path (get-location) -ChildPath "ubuntu"
if (-Not (Test-Path -Path $pathToUbuntu)) {
    Write-Log -Message "Path: $userEnvPath"  "WSL Install"
    [System.Environment]::SetEnvironmentVariable("PATH", $userEnvPath + (get-location) + "\ubuntu", "User")
}
else {
    Write-Log -Message "Path to ubuntu already added User Environment"  "WSL Install"
}
$userEnvPath = [System.Environment]::GetEnvironmentVariable("Path", "User")
Write-Log -Message "Path: $userEnvPath"  "WSL Install"
#>
