
Write-Host "Set Privacy Settings" -ForegroundColor Cyan

if((Read-Host -Prompt "Disable display web results in search(y/n)" ) -ilike "y*"){
    Set-WindowsSearchSetting -EnableWebResultsSetting $false -Verbose
}



Write-Host "Set general privacy options" -ForegroundColor Cyan
if((Read-Host -Prompt "Disable Send Language data(y/n)") -ilike "y*"){
    Set-ItemProperty "HKCU:\Control Panel\International\User Profile" -Name "HttpAcceptLanguageOptOut" -Value 1 -Verbose
}
if((Read-Host -Prompt "Disable allow set default printer") -ilike "y*"){
    Write-Host "The following entry will be created in the registry HKCU:\Printers\Defaults" -ForegroundColor Cyan
    mkdir "HKCU:\Printers\Defaults" -Force -Verbose
    Set-ItemProperty "HKCU:\Printers\Defaults" -Name "NetID" -Value "{00000000-0000-0000-0000-000000000000}" -Verbose
}
if((Read-Host -Prompt "Disable send Microsoft Info on how i write (y/n)") -ilike "y*"){
    Write-Host "The following entry will be created in the registry HKCU:\SOFTWARE\Microsoft\Input\TIPC" -ForegroundColor Cyan
    mkdir "HKCU:\SOFTWARE\Microsoft\Input\TIPC" -Force -Verbose
    Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Input\TIPC" -Name "Enabled" -Value 0 -Verbose
}
if((Read-Host -Prompt "Disable send advertising ID(y/n)") -ilike "y*"){
    Write-Host "The following entry will be created in the registry HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" -ForegroundColor Cyan
    mkdir "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" -Force -Verbose
    Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" -Name "Enabled" -Value 0 -Verbose
    Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost" -Name "EnableWebContentEvaluation" -Value 0 -Verbose
}

if((Read-Host -Prompt "Disable profile sync(y/n)") -ilike "y*"){
    Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync" -Name "BackupPolicy" -Value 0x3c -Verbose
    Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync" -Name "DeviceMetadataUploaded" -Value 0 -Verbose
    Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync" -Name "PriorLogons" -Value 1 -Verbose
    $groups = @(
        "Accessibility"
        "AppSync"
        "BrowserSettings"
        "Credentials"
        "DesktopTheme"
        "Language"
        "PackageState"
        "Personalization"
        "StartLayout"
        "Windows"
    )
    foreach ($group in $groups) {
        Write-Host "The following entry will be created in the registry HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\$group" -ForegroundColor Cyan
        mkdir "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\$group" -Force -Verbose
        Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\$group" -Name "Enabled" -Value 0
    }
}

if((Read-Host -Prompt "Set privacy policy accepted state to 0 (y/n)") -ilike "y*"){
    Write-Host "The following entry will be created in the registry HKCU:\SOFTWARE\Microsoft\Personalization\Settings" -ForegroundColor Cyan
    mkdir "HKCU:\SOFTWARE\Microsoft\Personalization\Settings" -Force -Verbose
    Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Personalization\Settings" -Name "AcceptedPrivacyPolicy" -Value 0
}

if((Read-Host -Prompt "Do not scan contact informations (y/n)") -ilike "y*"){
    Write-Host "The following entry will be created in the registry HKCU:\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore" -ForegroundColor Cyan
    mkdir "HKCU:\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore" -Force -Verbose
    Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore" -Name "HarvestContacts" -Value 0
}

if((Read-Host -Prompt "Disable Inking and typing collection (y/n)") -ilike "y*"){
    Write-Host "The following entry will be created in the registry HKCU:\SOFTWARE\Microsoft\InputPersonalization" -ForegroundColor Cyan
    mkdir "HKCU:\SOFTWARE\Microsoft\InputPersonalization" -Force -Verbose
    Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\InputPersonalization" -Name "RestrictImplicitInkCollection" -Value 1 -Verbose
    Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\InputPersonalization" -Name "RestrictImplicitTextCollection" -Value 1 -Verbose
}

if((Read-Host -Prompt "Config Microsoft Edge settings (y/n)") -ilike "y*"){
    Write-Host "The following entry will be created in the registry HKCU:\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\Main" -ForegroundColor Cyan
    mkdir "HKCU:\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\Main" -Force -Verbose
    Set-ItemProperty "HKCU:\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\Main" `
                -Name "DoNotTrack" -Value 1 -Verbose
    Write-Host "The following entry will be created in the registry HKCU:\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\User\Default\SearchScopes"
    mkdir "HKCU:\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\User\Default\SearchScopes" -Force -Verbose
    Set-ItemProperty "HKCU:\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\User\Default\SearchScopes" `
                -Name "ShowSearchSuggestionsGlobal" -Value 0 -Verbose
    Write-Host "The following entry will be created in the registry HKCU:\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\FlipAhead" -ForegroundColor Cyan
    mkdir "HKCU:\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\FlipAhead" -Force -Verbose
    Set-ItemProperty "HKCU:\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\FlipAhead" `
                -Name "FPEnabled" -Value 0 -Verbose
    Write-Host "The following entry will be created in the registry HKCU:\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\PhishingFilter" -ForegroundColor Cyan
    mkdir "HKCU:\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\PhishingFilter" -Force -Verbose
    Set-ItemProperty "HKCU:\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\PhishingFilter" `
                -Name EnabledV9 -Value 0 -Verbose
}

if((Read-Host -Prompt "Disable background access of default apps(y/n)") -ilike "y*"){
   foreach ($key in (ls "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications")) {
        Set-ItemProperty ("HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications\" + $key.PSChildName) -Name "Disabled" -Value 1 -Verbose
    } 
}

if((Read-Host -Prompt "Deny device access(y/n)") -ilike "y*"){
    Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\LooselyCoupled" -Name "Type" -Value "LooselyCoupled" -Verbose
    Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\LooselyCoupled" -Name "Value" -Value "Deny" -Verbose
    Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\LooselyCoupled" -Name "InitialAppValue" -Value "Unspecified" -Verbose
    foreach ($key in (ls "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global")) {
        Write-Host "Setting $($key.PSChildName)" -ForegroundColor Cyan
        if ($key.PSChildName -EQ "LooselyCoupled") {
            continue
        }
        Set-ItemProperty ("HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\" + $key.PSChildName) -Name "Type" -Value "InterfaceClass" -Verbose
        Set-ItemProperty ("HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\" + $key.PSChildName) -Name "Value" -Value "Deny" -Verbose
        Set-ItemProperty ("HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\" + $key.PSChildName) -Name "InitialAppValue" -value "Unspecified" -Verbose
    }
}
if((Read-Host -Prompt "Disable location sensor(y/n)" ) -ilike "y*"){
    Write-Host "The following entry will be created in the registry HKCU:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Permissions\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" -ForegroundColor Cyan
    mkdir "HKCU:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Permissions\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" -Force -Verbose
    Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Permissions\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" `
                    -Name "SensorPermissionState" -Value 0 -Verbose
}
if((Read-Host -Prompt "Do not share wifi networks(y/n)") -ilike "y*"){
    $user = New-Object System.Security.Principal.NTAccount($env:UserName)
    $sid = $user.Translate([System.Security.Principal.SecurityIdentifier]).value
    Write-Host "The following entry will be created in the registry $("HKLM:\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\features\" + $sid)" -ForegroundColor Cyan
    mkdir ("HKLM:\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\features\" + $sid) -Force -Verbose
    Set-ItemProperty ("HKLM:\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\features\" + $sid) -name "FeatureStates" -value 0x33c -Verbose
    Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\features" -name "WiFiSenseCredShared" -value 0 -Verbose
    Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\features" -name "WiFiSenseOpen" -value 0 -Verbose
    
}

 