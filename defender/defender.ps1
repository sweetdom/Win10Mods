#   Description:
# This script disables Windows Defender.

Write-Host "Removing scheduled tasks" -ForegroundColor Yellow

$tasks = @(
    "\Microsoft\Windows\Windows Defender\Windows Defender Cache Maintenance"
    "\Microsoft\Windows\Windows Defender\Windows Defender Cleanup"
    "\Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan"
    "\Microsoft\Windows\Windows Defender\Windows Defender Verification"
)

foreach ($task in $tasks) {
    $parts = $task.split('\')
    $name = $parts[-1]
    $path = $parts[0..($parts.length-2)] -join '\'

    Write-Host "Trying to disable scheduled task $name" -ForegroundColor Cyan
    Disable-ScheduledTask -TaskName "$name" -TaskPath "$path"
}

Write-Host "Disabling Windows Defender via Group Policies" -ForegroundColor Cyan

Write-Host "The following entry will be created in the registry HKLM:\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows Defender" -ForegroundColor Cyan
Start-Sleep -Seconds 2
mkdir "HKLM:\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows Defender" -Force -Verbose
Set-ItemProperty "HKLM:\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows Defender" -Name "DisableAntiSpyware" -Value 1 -Verbose
Set-ItemProperty "HKLM:\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows Defender" -Name "DisableRoutinelyTakingAction" -Value 1 -Verbose

Write-Host "The following entry will be created in the registry HKLM:\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows Defender\Real-Time Protection" -ForegroundColor Cyan
mkdir "HKLM:\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows Defender\Real-Time Protection" -Force -Verbose
Set-ItemProperty "HKLM:\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows Defender\Real-Time Protection" -Name "DisableRealtimeMonitoring" -Value 1 -Verbose

Write-Host "Removing Windows Defender context menu item" -ForegroundColor Cyan
Set-Item "HKLM:\SOFTWARE\Classes\CLSID\{09A47860-11B0-4DA5-AFA5-26D86198A780}\InprocServer32" -Value "" -Verbose

