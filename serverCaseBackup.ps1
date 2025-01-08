##################################################
# Backup script for server automatization 2 case #
##################################################

<#
.DESCRIPTION
    This script is made for server automatization 2 case by Nicolas Hedrich.
    This script is able to pull folders and files remote to a local destination.

.EXAMPLE


.NOTES
    Author: Nicolas Hedrich
    Version: 0.2
    Release date: 08-01-2025
#>

# Config.json location and translation.
$configFilePath = ".\Config.json" # Variable that contains Config.json path.
$configContent = Get-Content -Path $configFilePath -Raw | ConvertFrom-Json # Makes the script able to read and translate the Config.json file.

# Config.json content.
$localDestination = $configContent.localDestination
$logDestination = $configContent.logDestination
$remoteDestination = $configContent.remoteDestination
$backupName = $configContent.backupName

# Main script function.
function RemoteBackup {

    # Start logging.
    Start-Transcript -Path $logDestination
    Clear-Host

    # Checks if folder exist. If folder doesn't exist it will be created.
    if (-Not (Test-Path -Path $localDestination)) { 
        New-Item -ItemType Directory -Path $localDestination
        Clear-Host
    }

    while ($true) {

        # Variables that contains IP and credentials. <#
        $remoteIp = Read-Host "Enter IP of destiantion host.`n"
        Clear-Host 
        $username = Read-Host "Enter username for remote host (Has to have administrative rights).`n"
        Clear-Host 
        $password = Read-Host "Enter password of user.`n"
        Clear-Host 
        $securePassword = ConvertTo-SecureString $password -AsPlainText -Force 
        $credential = New-Object System.Management.Automation.PSCredential ($username, $securePassword)

        try { 
            $session = New-PSSession -ComputerName $remoteIp -Credential $credential
            Write-Host "Connection to remote host was established." 
            Pause
            Break
            Clear-Host
        } 
        catch { 
            Write-Host "Could not reach host. Try again."
            Pause
            Clear-Host
        }
    }

    robocopy \\127.0.0.1\c$\temp \\192.168.185.240$localDestination /E /Z /ZB /R:5 /W:5 /TBD /V /MT:16
    Read-Host = "`n`nPress any key to close script"

    Remove-PSSession -Session $session

    # Stop logging.
    Stop-Transcript

}    
RemoteBackup