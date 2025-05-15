function Write-Log {
    param (
        [string]$Message,
        [string]$ModuleName = "General"
    )

    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logMessage = "[$timestamp] [$ModuleName] $Message"

    Write-Host $logMessage
}

function Get-UserInput {
    param (
        [string]$Prompt,
        [string]$DefaultValue
    )

    # Display the prompt with the default value suggestion
    $userInput = Read-Host "$Prompt (Default: $DefaultValue)"

    # If the input is blank, return the default value
    if ([string]::IsNullOrWhiteSpace($userInput)) {
        return $DefaultValue
    }

    return $userInput
}

function Get-BoundedUserInput {
    param (
        [string]$Prompt,
        [string[]]$ValidOptions,
        [string]$ModuleName
    )

    while ($true) {
        $userInput = Read-Host "$Prompt"

        if ($ValidOptions -contains $userInput) {
            return $userInput
        }
        else {
            Write-Output "Invalid input. Please enter one of the following options: $($ValidOptions -join ', ')" $ModuleName
        }
    }
}
