#################################################
# Backup script til serverautomatisering 2 case #
#################################################

# Variabler til scriptet
$localDestination = ".\Backup" # Filsti hvor backup skal hentes til.
$logDestinantion = ".\Logs" # Filsti hvor log skal hentes til.
$remoteIp = Read-Host "Enter IP of destiantion host.`n" # IP adresse på server, hvor backup skal tages fra.
Clear-Host
$username = Read-Host "Enter username for remote host (Has to have administrative rights).`n" # Indtast username på fjerncomputer. Skal have administrative rettigheder.
Clear-Host
$password = Read-Host "Enter password of user.`n" # Indtast password til username.
Clear-Host
$securePassword = ConvertTo-SecureString $password -AsPlainText -Force # Tvinger variablen password til at være en secure string.
$credential = New-Object System.Management.Automation.PSCredential ($username, $securePassword) # Variabel som indenholder username og password.
$logName = "Log.txt"

# Funktion som indenholder scriptet.
function RemoteBackup {
    
    # While loop, som sørger for korrekt input fra brugeren.
    while ($true) {
        $remoteDestination = Read-Host "Enter 1 for default remote location (C:\Temp).`nEnter 2 for manual input.`n" # Filsti på fjerncomputer, som skal have taget backup. Mulighed for default og manuelt input.

        if ($remoteDestination -eq 1) { # Hvis brugerens input er lig med 1, vil variablen få indholdet under.
            $remoteDestination = "C:\Temp"
            Clear-Host
            break
        }
        elseif ($remoteDestination -eq 2) { # Hvis brugerens input er lig med 2, vil variablen få indholdet under.
            $remoteDestination = Read-Host "Enter remote destination (Example: C:\Temp)`n"
            Clear-Host
            break
        }
        else { # Hvis brugerens input er ugyldingt, vil loekken starte forfra.
            Write-Host "Wrong input. Please try again."
            pause
            Clear-Host
        }
    }

    # While loop, som sørger for korrekt input fra brugeren.
    while ($true) {
        $backupName = Read-Host "Enter 1 for default backup file name (BackupOfTempFolder).`nEnter 2 for manual input.`n" # Navn på backup fil. Mulighed for default og manuelt input.

        if ($backupName -eq 1) { # Hvis brugerens input er lig med 1, vil variablen få indholdet under.
            $backupName = "BackupOfTempFolder"
            Clear-Host
            break
        }
        elseif ($backupName -eq 2) { # Hvis brugerens input er lig med 2, vil variablen få indholdet under.
            $backupName = Read-Host "Enter backup folder name (Example: BackupOfTempFolder)`n"
            Clear-Host
            break
        }
        else { # Hvis brugerens input er ugyldingt, vil loekken starte forfra.
            Write-Host "Wrong input. Please try again."
            pause
            Clear-Host
        }
    }

    try { 
        $session = New-PSSession -ComputerName $remoteIp -Credential $credential 
        Write-Host "Credentials are valid." 
        Remove-PSSession -Session $session
        Pause
        Clear-Host
    } 
    catch { 
        Write-Host "Invalid credentials. Please try again."
        Pause
        Clear-Host
    }
}
RemoteBackup