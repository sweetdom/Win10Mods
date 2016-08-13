Clear-Host
$oldExecutionPolicy = Get-ExecutionPolicy
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Force -Verbose
$banner = @"
###############################################################################################################
#                        +-+-+-+-+-+-+-+ +-+-+ +-+-+-+-+-+-+-+ +-+-+-+-+-+-+                                  #
#                        |W|i|n|d|o|w|s| |1|0| |P|r|i|v|a|c|y| |S|c|r|i|p|t|                                  #
#                        +-+-+-+-+-+-+-+ +-+-+ +-+-+-+-+-+-+-+ +-+-+-+-+-+-+                                  #
#                                                                                                             #
#            This is a collection of mods found on the Internet and should be used with Caution               #
###############################################################################################################
"@

$disclaimer = @"
    This script makes modification to windows and should be used at your own risk, 
    please make sure you know what you are doing. I will not take any responsibility for 
    the actions this script takes please read it closely 

    This Script will also reboot your computer so please close everything
"@

[bool]$isAdmin = (([System.Security.Principal.WindowsIdentity]::GetCurrent()).groups -match "S-1-5-32-544")
if(!($isAdmin)){
    Write-Host "Please run this script as an admin" -ForegroundColor Red
    Read-Host
    exit
}

Write-Host $banner -ForegroundColor Yellow
Write-Host $disclaimer -ForegroundColor Red

$Continue = Read-Host -Prompt "Continue?(yes/no)"

$ErrorActionPreference = "Stop"

Switch($Continue){
    "yes"{
        Write-Host "OK"
    }
    "No"{
        Write-Error "Stopping Script"
    }
    Default{
        Write-Error "Stopping Script"
    }
}

$ErrorActionPreference = "Continue"

$msg = @"
    The windows store app section of the script will let you remove 
    some of the built in apps that come with windows. Microsoft 
    sometimes like to leave a relic of the old app in the start 
    menu so you can download it again just right click on it and 
    pick don't list. All new users will not see it on the computer.
    Note you can also remove the windows store app but do this 
    with caution I do not know how this will effect your system in the future
    for example it is possible the the linux subsystem relies on this to inatll.
"@

Write-Host $msg -ForegroundColor Yellow
if((Read-Host -Prompt "Run the appx part of the script(y/n)") -ilike "y*"){
    & "$PSScriptRoot\appx\appx.ps1"
}

$msg = @"
    Windows Defender is integrated into windows this script will try its best to disable it 
    like any part of this please use it with caution
"@

Write-Host $msg -ForegroundColor Yellow
if((Read-Host -Prompt "Run the Windows defender part of the script(y/n)") -ilike "y*"){
    & "$PSScriptRoot\defender\defender.ps1"
}

$msg = @"
    Windows onedrive is integrated into windows this script 
    will try its best to disable it like any part of this
    please use it with caution. This script will also 
    remove it from explorer so it will need to close it.
"@

Write-Host $msg -ForegroundColor Yellow
if((Read-Host -Prompt "Run the Windows onedrive part of the script(y/n)") -ilike "y*"){
    & "$PSScriptRoot\onedrive\onedrive.ps1"
}

$msg = @"
    This will let you choose to disable windows services.
"@

Write-Host $msg -ForegroundColor Yellow
if((Read-Host -Prompt "Run the services part of the script(y/n)") -ilike "y*"){
    & "$PSScriptRoot\services\services.ps1"
}

$msg = @"
    Windows update settings.
"@

Write-Host $msg -ForegroundColor Yellow
if((Read-Host -Prompt "Run the Windows update part of the script(y/n)") -ilike "y*"){
    & "$PSScriptRoot\windowsupdate\windowsupdate.ps1"
}

$msg = @"
    This part of the script backups and alters your host file 
    by adding well known telemetry domains and pointing them 
    to dummy ip's. It also adds ip's to the firewall that get
     blocked. You can edit the files located at
    "$PSScriptRoot\telemetry\telemetry.ps1"
"@

Write-Host $msg -ForegroundColor Yellow
if((Read-Host -Prompt "Run the Windows telemetry part of the script(y/n)") -ilike "y*"){
    & "$PSScriptRoot\telemetry\telemetry.ps1"
}

$msg = @"
    This part of the script edits the privacy settings 
    located in settings
"@

Write-Host $msg -ForegroundColor Yellow
if((Read-Host -Prompt "Run the Windows privacy part of the script(y/n)") -ilike "y*"){
    & "$PSScriptRoot\privacy\privacy.ps1"
}

$msg = @"
    Windows tweaks and mods
"@

Write-Host $msg -ForegroundColor Yellow
if((Read-Host -Prompt "Run the Windows mods part of the script(y/n)") -ilike "y*"){
    & "$PSScriptRoot\mods\mods.ps1"
}

Set-ExecutionPolicy -ExecutionPolicy $oldExecutionPolicy -Force -Verbose
Write-Host "You must Reboot your computer"

if((Read-Host -Prompt "Reboot your computer(y/n)") -ilike "y*"){
Restart-Computer -Force
}