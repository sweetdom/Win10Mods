#   Description:
# This script will remove and disable OneDrive integration.


Write-Host "Kill OneDrive process" -ForegroundColor Cyan
Stop-Process -Name OneDrive -Force -Verbose
Stop-Process -Name explorer -Force -Verbose

Write-Host "Remove OneDrive" -ForegroundColor Cyan
if (Test-Path "$env:systemroot\System32\OneDriveSetup.exe") {
    & "$env:systemroot\System32\OneDriveSetup.exe" /uninstall
}
if (Test-Path "$env:systemroot\SysWOW64\OneDriveSetup.exe") {
    & "$env:systemroot\SysWOW64\OneDriveSetup.exe" /uninstall
}

Write-Host "Removing OneDrive leftovers" -ForegroundColor Cyan
Remove-Item "$env:localappdata\Microsoft\OneDrive" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
Remove-Item "$env:programdata\Microsoft OneDrive" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
Remove-Item "$env:userprofile\OneDrive" -Recurse -Force -ErrorAction SilentlyContinue -Verbose
Remove-Item "C:\OneDriveTemp" -Recurse -Force -ErrorAction SilentlyContinue -Verbose

Write-Host "Disable OneDrive via Group Policies" -ForegroundColor Cyan
Write-Host "The following entry will be created in the registry HKLM:\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\OneDrive" -ForegroundColor Cyan
mkdir "HKLM:\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\OneDrive" -Force -Verbose
Set-ItemProperty "HKLM:\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\OneDrive" -Name "DisableFileSyncNGSC" -Value 1

Write-Host "Removing Onedrive from explorer sidebar" -ForegroundColor Cyan
New-PSDrive -PSProvider "Registry" -Root "HKEY_CLASSES_ROOT" -Name "HKCR" -Verbose
Write-Host "The following entry will be created in the registry HKCR:\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" -ForegroundColor Cyan
Start-Sleep -Seconds 3
mkdir "HKCR:\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" -Force -Verbose
Set-ItemProperty "HKCR:\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" -Name "System.IsPinnedToNameSpaceTree" -Value 0 -Verbose
Write-Host "The following entry will be created in the registry HKCR:\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" -ForegroundColor Cyan
Start-Sleep -Seconds 3
mkdir "HKCR:\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" -Force -Verbose
Set-ItemProperty "HKCR:\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" -Name "System.IsPinnedToNameSpaceTree" -Value 0 -Verbose
Remove-PSDrive "HKCR" -Verbose

Write-Host "Removing startmenu entry" -ForegroundColor Cyan
Remove-Item "$env:userprofile\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\OneDrive.lnk" -Force -ErrorAction SilentlyContinue -Verbose

Write-Host "Restarting explorer" -ForegroundColor Cyan
Start-Process "explorer.exe"

Write-Host "Waiting for explorer to complete loading" -ForegroundColor Cyan
start-sleep -Seconds 10