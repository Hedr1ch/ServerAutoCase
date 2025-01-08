This script is made for server automatization 2 case by Nicolas Hedrich.
This script is able to pull folders and files remote to a local destination.


[How to]
The config.json file has to be edited to be able to work proberly.

"localDestination": ".\\Backup"
    This variable is where the backup is stored local (Default: .\\Backup)

"logDestination": ".\\Log"
    This variable is where the log is stored local and the name (Default: .\\Log)
    *IMPORTANT* If the script is run again, it will overwrite the exitsing log file. Please change the name, if the old file needs to be saved.
    
"remoteDestination": "C:\\Temp"
    This variable is the remote destination that you want to copy (Default: C:\\Temp)

"backupName":  "ServerBackup"
    This variable is the name of the backup folder (Default: ServerBackup)
    *IMPORTANT* If the script is run again, it will overwrite the exitsing backup file. Please change the name, if the old file needs to be saved.


[Version]
Release version 0.2 (08-01-2025) by Nicolas Hedrich