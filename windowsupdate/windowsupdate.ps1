Write-Host "Disable automatic download and installation of Windows updates" -ForegroundColor Cyan
Write-Host "The following entry will be created in the registry HKLM:\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\WindowsUpdate\AU" -ForegroundColor Cyan
mkdir "HKLM:\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\WindowsUpdate\AU" -Force -Verbose
Set-ItemProperty "HKLM:\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "NoAutoUpdate" -Value 0 -Verbose
Set-ItemProperty "HKLM:\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "AUOptions" -value 2 -Verbose
Set-ItemProperty "HKLM:\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "ScheduledInstallDay" -value 0 -Verbose
Set-ItemProperty "HKLM:\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "ScheduledInstallTime" -value 3 -Verbose

Write-Host "Disable seeding of updates to other computers via Group Policies" -ForegroundColor Cyan
Write-Host "The following entry will be created in the registry HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" -ForegroundColor Cyan
mkdir "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" -Force -Verbose
Set-ItemProperty "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" -Name "DODownloadMode" -value 0 -Verbose

if((Read-Host -Prompt "Disabling automatic driver update(y/n)") -ilike "y*"){
    Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" -Name "SearchOrderConfig" -Value 0 -Verbose
}

Write-Host "To Disable update notifications is very experimental use at your own risk" -ForegroundColor Red
if((Read-Host -Prompt "Disable update notifications(y/n)") -ilike "y*"){
    takeown /F "$env:WinDIR\System32\MusNotification.exe"
    icacls "$env:WinDIR\System32\MusNotification.exe" /deny "Everyone:(X)"
    takeown /F "$env:WinDIR\System32\MusNotificationUx.exe"
    icacls "$env:WinDIR\System32\MusNotificationUx.exe" /deny "Everyone:(X)"
}