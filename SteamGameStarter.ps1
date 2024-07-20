# Hardcoded credentials and game ID
# delete "DELETETHIS" and change it to your name between " " so if your account is superman21 itd be "superman21"
$username = "DELETETHIS"

# This is Dark And Darker ID, from https://store.steampowered.com/app/2016590/Dark_and_Darker/
$gameID = "2016590"
$steamRegistryPath = "HKCU:\Software\Valve\Steam"

function Get-SteamPath {
    try {
        $steamExePath = (Get-ItemProperty -Path $steamRegistryPath -Name "SteamExe").SteamExe
        return $steamExePath
    } catch {
        Write-Host "Failed to get the Steam executable path from the registry."
        return $null
    }
}

function Get-SteamLoggedInUser {
    try {
        $currentAccount = (Get-ItemProperty -Path $steamRegistryPath -Name "AutoLoginUser").AutoLoginUser
        return $currentAccount
    } catch {
        Write-Host "Failed to get the current logged-in user."
        return $null
    }
}

function Set-SteamAutoLoginUser {
    param (
        [string]$newUsername
    )
    try {
        Set-ItemProperty -Path $steamRegistryPath -Name "AutoLoginUser" -Value $newUsername
        Set-ItemProperty -Path $steamRegistryPath -Name "RememberPassword" -Value 1
        Write-Host "Set AutoLoginUser to $newUsername"
    } catch {
        Write-Host "Failed to set the AutoLoginUser."
    }
}

function Wait-ForProcessExit {
    param (
        [string]$processName
    )
    Write-Host "Waiting for $processName to exit..."
    while (Get-Process -Name $processName -ErrorAction SilentlyContinue) {
        Start-Sleep -Seconds 1
    }
}

function Wait-ForProcessStart {
    param (
        [string]$processName
    )
    Write-Host "Waiting for $processName to start..."
    while (-not (Get-Process -Name $processName -ErrorAction SilentlyContinue)) {
        Start-Sleep -Seconds 1
    }
}

$steamPath = Get-SteamPath

if (-not $steamPath) {
    Write-Host "Unable to find Steam executable path. Exiting script."
    Exit
}

$currentAccount = Get-SteamLoggedInUser

if ($currentAccount -eq $username) {
    Write-Host "Already logged in with the correct account: $username"
} else {
    if (Get-Process -Name steam -ErrorAction SilentlyContinue) {
        Write-Host "Logging out of current Steam account"
        Stop-Process -Name steam -Force

        # Wait for Steam to fully exit
        Wait-ForProcessExit -processName "steam"
    } else {
        Write-Host "Steam is not currently running."
    }

    # Wait for Steam to fully exit
    Wait-ForProcessExit -processName "steam"

    Write-Host "Setting AutoLoginUser to $username"
    Set-SteamAutoLoginUser -newUsername $username

    Write-Host "Logging into Steam with user: $username"
    Start-Process -FilePath $steamPath

    # Wait for Steam to start
    Wait-ForProcessStart -processName "steam"

    # Optionally add a wait to ensure Steam is fully loaded
    Start-Sleep -Seconds 10
}

# Launch the specified game
Write-Host "Launching game with ID: $gameID"
Start-Process -FilePath $steamPath -ArgumentList "-applaunch $gameID"

# Add a sleep to ensure the game has time to start
Start-Sleep -Seconds 10

# Close PowerShell
Exit
