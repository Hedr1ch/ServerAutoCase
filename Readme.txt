This script is made for server automatization 2 case by Nicolas Hedrich.
This script is able to pull folders and files remote to a local destination.


[How to]
For this script to be able to run proberly. Pssession has to be enabled on both devices. To do this run the following command.

Enable-PSRemoting -Force

If the devices are not domain joined, they might not trust eachother. Run the following commands, to set trusted ip.

Set-Item WSMan:localhost\client\trustedhosts -value ""
Get-Item WSMan:localhost\client\trustedhosts

The config.json file has to be edited to be able to work proberly.

"sourcePath": "C:\\Temp"
    This variable is the remote destination that you want to copy (Default: C:\\Temp)

"logDestination": ".\\Log"
    This variable is where the log is stored local and the name (Default: .\\Log)
    *IMPORTANT* If the script is run again, it will overwrite the exitsing log file. Please change the name, if the old file needs to be saved.

"destinationPath": ".\\Backup"
    This variable is where the backup is stored local (Default: .\\Backup)
    *IMPORTANT* If the script is run again, it will overwrite the exitsing backup folder. Please change the name, if the old file needs to be saved.

"destinationIP": ""
    This variable contains the ip of the destination, where you want the backup to be (Example: "192.168.0.1")

"remoteIP": ""
    This variable contains the ip of the remote host, where the files you want a backup from exist (Example: "192.168.0.1")

The script will ask for login credintals. When prompted please enter credintals with administrator rights.

For more infomation please check log.


[Version]
Release version 1.0 (09-01-2025) by Nicolas Hedrich