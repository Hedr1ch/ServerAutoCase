##################################################
# Backup script for server automatization 2 case #
##################################################

<#
.DESCRIPTION
    This script is made for server automatization 2 case by Nicolas Hedrich.
    This script is able to pull folders and files remote to a local destination.

.EXAMPLE
    You need to do a backup daily on a remote server. This script will be able to do this, and store the files local.

.NOTES
    Author: Nicolas Hedrich
    Version: 1.0
    Release date: 09-01-2025
#>

# Config.json location and translation.
$configFilePath = ".\Config.json" # Variable that contains Config.json path.
$configContent = Get-Content -Path $configFilePath -Raw | ConvertFrom-Json # Makes the script able to read and translate the Config.json file.

# Config.json content.
$sourcePath = $configContent.sourcePath
$logDestination = $configContent.logDestination
$destinationPath = $configContent.destinationPath
$destinationIP = $configContent.destinationIP
$remoteIp = $configContent.remoteIP

# Main script function.
function RemoteBackup {

    # Start logging.
    Start-Transcript -Path $logDestination
    Clear-Host

    # Checks if folder exist. If folder doesn't exist it will be created.
    if (-Not (Test-Path -Path $destinationPath)) { 
        New-Item -ItemType Directory -Path $destinationPath
        Clear-Host
    }

    # While loop, that makes sure not to come any further in the script, before a connection can be established.
    while ($true) {

        # Variables that contains credentials.
        $username = Read-Host "Enter username for remote host (Has to have administrative rights).`n"
        Clear-Host 
        $password = Read-Host "Enter password of user.`n"
        Clear-Host 
        $securePassword = ConvertTo-SecureString $password -AsPlainText -Force 
        $credential = New-Object System.Management.Automation.PSCredential ($username, $securePassword)

        # Try to connect to the remote server with the given ip and credentials.
        try { 
            $session = New-PSSession -ComputerName $remoteIp -Credential $credential
            Remove-PSSession -Session $session
            Clear-Host
            Break
        } 

        # If the connection is unsuccesful. The script will ask for credentials again.
        catch { 
            Write-Host "Could not reach host. Try again."
            Pause
            Clear-Host
        }
    }

    # When the script knows it can establish a connection. It will invoke the backup procedure.
    Invoke-Command -ComputerName $remoteIp -Credential $credential -ScriptBlock {
        param ($sourcePath, $destinationPath, $destinationIP)
        robocopy $sourcePath \\$destinationIP\$destinationPath /E /MIR /MT16
    } -ArgumentList $sourcePath, $destinationPath, $destinationIP

    Read-Host = "`n`nPress any key to close script"

    # Stop logging.
    Stop-Transcript

}    
RemoteBackup