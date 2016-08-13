if((Read-Host -Prompt "Apply MarkC's mouse acceleration fix(y/n)") -ilike "y*"){
    Set-ItemProperty "HKCU:\Control Panel\Mouse" -Name "MouseSensitivity" -Value "10" -Verbose
    Set-ItemProperty "HKCU:\Control Panel\Mouse" -Name "MouseSpeed" -Value "0" -Verbose
    Set-ItemProperty "HKCU:\Control Panel\Mouse" -Name "MouseThreshold1" -Value "0" -Verbose
    Set-ItemProperty "HKCU:\Control Panel\Mouse" -Name "MouseThreshold2" -Value "0" -Verbose
    Set-ItemProperty "HKCU:\Control Panel\Mouse" -Name "SmoothMouseXCurve" -Value ([byte[]](0x00, 0x00, 0x00,
    0x00, 0x00, 0x00, 0x00, 0x00, 0xC0, 0xCC, 0x0C, 0x00, 0x00, 0x00, 0x00, 0x00,
    0x80, 0x99, 0x19, 0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x66, 0x26, 0x00, 0x00,
    0x00, 0x00, 0x00, 0x00, 0x33, 0x33, 0x00, 0x00, 0x00, 0x00, 0x00)) -Verbose
    Set-ItemProperty "HKCU:\Control Panel\Mouse" -Name "SmoothMouseYCurve" -value ([byte[]](0x00, 0x00, 0x00,
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x38, 0x00, 0x00, 0x00, 0x00, 0x00,
    0x00, 0x00, 0x70, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xA8, 0x00, 0x00,
    0x00, 0x00, 0x00, 0x00, 0x00, 0xE0, 0x00, 0x00, 0x00, 0x00, 0x00)) -Verbose
}

if((Read-Host -Prompt "Disable mouse pointer hiding(y/n)") -ilike "y*"){
    Set-ItemProperty "HKCU:\Control Panel\Desktop" -Name "UserPreferencesMask" -value ([byte[]](0x9e,
    0x1e, 0x06, 0x80, 0x12, 0x00, 0x00, 0x00)) -Verbose
}

if((Read-Host -Prompt "Disable easy access keyboard stuff(y/n)") -ilike "y*"){
    Set-ItemProperty "HKCU:\Control Panel\Accessibility\StickyKeys" -Name "Flags" -value "506" -Verbose
    Set-ItemProperty "HKCU:\Control Panel\Accessibility\Keyboard Response" -Name "Flags" -Value "122" -Verbose
    Set-ItemProperty "HKCU:\Control Panel\Accessibility\ToggleKeys" -Name "Flags" -Value "58" -Verbose
}

if((Read-Host -Prompt "Restore old volume slider(y/n)") -ilike "y*"){
    Write-Host "The following entry will be created in the registry HKLM:\Software\Microsoft\Windows NT\CurrentVersion\MTCUVC" -ForegroundColor Cyan
    mkdir "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\MTCUVC" -Force -Verbose
    Set-ItemProperty "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\MTCUVC" -Name "EnableMtcUvc" -value 0 -Verbose
}

if((Read-Host "Set folder view options(y/n)") -ilike "y*"){
    Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Hidden" -Value 1 -Verbose
    Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Value 0 -Verbose
    Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideDrivesWithNoMedia" -value 0 -Verbose
}

#Need to fix this it causes an error from the task bar
#if((Read-Host -Prompt "Set default explorer view to {This PC}(y/n)") -ilike "y*"){
#    Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "LaunchTo" -Value 0 -Verbose
#}


if((Read-Host -Prompt "Disable login screen background image(y/n)") -ilike "y*"){
    Write-Host "The following entry will be created in the registry HKLM:\Software\Policies\Microsoft\Windows\System" -ForegroundColor Cyan
    mkdir "HKLM:\Software\Policies\Microsoft\Windows\System" -Force -Verbose
    Set-ItemProperty "HKLM:\Software\Policies\Microsoft\Windows\System" -Name "DisableLogonBackgroundImage" -value 1 -Verbose
}

if((Read-Host -Prompt "Disabling new lock screen(y/n)") -ilike "y*"){
    Write-Host "The following entry will be created in the registry HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization" -ForegroundColor Cyan
    mkdir "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization"  -Force -Verbose
    Set-ItemProperty "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization" -Name "NoLockScreen" -Value 1 -Verbose
}

if((Read-Host -Prompt "Disable startmenu search features(y/n)") -ilike "y*"){
    Write-Host "The following entry will be created in the registry HKLM:\Software\Policies\Microsoft\Windows\Windows Search" -ForegroundColor Cyan
    mkdir "HKLM:\Software\Policies\Microsoft\Windows\Windows Search" -Force -Verbose
    Set-ItemProperty "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search\" -Name AllowCortana -value 0 -Verbose
    Set-ItemProperty "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search\" -Name DisableWebSearch -value 1 -Verbose
    Set-ItemProperty "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search\" -name AllowSearchToUseLocation -value 0 -Verbose
    Set-ItemProperty "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search\" -Name ConnectedSearchUseWeb -Value 0 -Verbose
}

if((Read-Host -Prompt "Disable AutoRun(y/n)") -ilike "y*"){
    Write-Host "The following entry will be created in the registry HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -ForegroundColor Cyan
    mkdir "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Force -Verbose
    Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "NoDriveTypeAutoRun" -Value 0xff -Verbose
    Write-Host "The following entry will be created in the registry HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -ForegroundColor Cyan
    mkdir "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Force -Verbose
    Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "NoDriveTypeAutoRun" -Value 0xff -Verbose
}

Write-Host "Removing user folders on explorer under {This PC}" -ForegroundColor Cyan
if((Read-Host -Prompt "Remove Desktop from {This PC}(y/n") -ilike "y*"){
    Remove-Item "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" -Verbose
    Remove-Item "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" -Verbose
}
if((Read-Host -Prompt "Remove Documents from {This PC}(y/n)") -ilike "y*"){
    Remove-Item "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A8CDFF1C-4878-43be-B5FD-F8091C1C60D0}" -Verbose
    Remove-Item "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}" -Verbose
    Remove-Item "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A8CDFF1C-4878-43be-B5FD-F8091C1C60D0}" -Verbose
    Remove-Item "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}" -Verbose
}
if((Read-Host -Prompt "Remove Downloads from {This PC}(y/n)") -like "y*"){
    Remove-Item "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{374DE290-123F-4565-9164-39C4925E467B}" -Verbose
    Remove-Item "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}" -Verbose
    Remove-Item "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{374DE290-123F-4565-9164-39C4925E467B}" -Verbose
    Remove-Item "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}" -Verbose
}
if((Read-Host -Prompt "Remove Music from {This PC}(y/n)") -ilike "y*"){
    Remove-Item "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}" -Verbose
    Remove-Item "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" -Verbose
    Remove-Item "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}" -Verbose
    Remove-Item "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" -Verbose
}
if((Read-Host -Prompt "Remove Pictures from {This PC}(y/n)") -ilike "y*"){
    Remove-Item "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3ADD1653-EB32-4cb0-BBD7-DFA0ABB5ACCA}" -Verbose
    Remove-Item "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}" -Verbose
    Remove-Item "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3ADD1653-EB32-4cb0-BBD7-DFA0ABB5ACCA}" -Verbose
    Remove-Item "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}" -Verbose
}
if((Read-Host "Remove Videos from {This PC}(y/n)") -ilike "y*"){
    Remove-Item "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A0953C92-50DC-43bf-BE83-3742FED03C9C}" -Verbose
    Remove-Item "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" -Verbose
    Remove-Item "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A0953C92-50DC-43bf-BE83-3742FED03C9C}" -Verbose
    Remove-Item "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" -Verbose
}

if((Read-Host -Prompt "Remove all tiles from start menu(y/n)") -ilike "y*"){
    $e = (New-Object -Com Shell.Application).NameSpace('shell:::{4234d49b-0245-4df3-b780-3893943456e1}')
    $e.Items() | %{$_.Verbs()} | ?{$_.Name.replace('&','') -match 'Unpin from Start'} | %{$_.DoIt()}
}


Write-Host "God Mode creates a shorcut on your desktop that gives you all settings in one place"
if((Read-Host -Prompt "Create God Mode Shortcut(y/n)") -ilike "y*"){
echo @"
###############################################################################
#       _______  _______  ______     __   __  _______  ______   _______       #
#      |       ||       ||      |   |  |_|  ||       ||      | |       |      #
#      |    ___||   _   ||  _    |  |       ||   _   ||  _    ||    ___|      #
#      |   | __ |  | |  || | |   |  |       ||  | |  || | |   ||   |___       #
#      |   ||  ||  |_|  || |_|   |  |       ||  |_|  || |_|   ||    ___|      #
#      |   |_| ||       ||       |  | ||_|| ||       ||       ||   |___       #
#      |_______||_______||______|   |_|   |_||_______||______| |_______|      #
#                                                                             #
#      God Mode has been enabled, check out the new link on your Desktop      #
#                                                                             #
###############################################################################
"@
mkdir "$env:UserProfile\Desktop\GodMode.{ED7BA470-8E54-465E-825C-99712043E01C}"
}