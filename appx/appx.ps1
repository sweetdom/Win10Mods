$apps = @(
    "Microsoft.3DBuilder"
    "Microsoft.Appconnector"
    "Microsoft.BingFinance"
    "Microsoft.BingNews"
    "Microsoft.BingSports"
    "Microsoft.BingWeather"
    "Microsoft.Getstarted"
    "Microsoft.MicrosoftOfficeHub"
    "Microsoft.MicrosoftSolitaireCollection"
    "Microsoft.Office.OneNote"
    "Microsoft.People"
    "Microsoft.SkypeApp"
    "Microsoft.Windows.Photos"
    "Microsoft.WindowsAlarms"
    "Microsoft.WindowsCalculator"
    "Microsoft.WindowsCamera"
    "Microsoft.WindowsMaps"
    "Microsoft.WindowsPhone"
    "Microsoft.WindowsSoundRecorder"
    "Microsoft.WindowsStore"
    "Microsoft.XboxApp"
    "Microsoft.ZuneMusic"
    "Microsoft.ZuneVideo"
    "microsoft.windowscommunicationsapps"
    "Microsoft.MinecraftUWP"
    "Microsoft.CommsPhone"
    "Microsoft.ConnectivityStore"
    "Microsoft.Messaging"
    "Microsoft.Office.Sway"
    "9E2F88E3.Twitter"
    "Flipboard.Flipboard"
    "ShazamEntertainmentLtd.Shazam"
    "king.com.CandyCrushSaga"
    "king.com.CandyCrushSodaSaga"
    "king.com.*"
    "ClearChannelRadioDigital.iHeartRadio"
)

$msg = @"
If you still see the icon in the start menu just righ click on it and choose do not list, 
Microsoft wants to leave it there incase you want to redownload it
"@

Write-Host $msg -ForegroundColor Yellow

foreach ($app in $apps) {
    if($app -eq "Microsoft.WindowsStore" ){
        Write-Warning "Microsoft.WindowsStore is an important app and may be used in the future more..."
    }

    if((Read-Host -Prompt "Remove $app (y/n)") -ilike "y*"){
        Write-Host "Trying to remove $app" -ForegroundColor Cyan

        Get-AppxPackage -Name $app -AllUsers | Remove-AppxPackage -Verbose

        Get-AppXProvisionedPackage -Online |
                ? {$_.DisplayName -EQ $app} -Verbose |
                    Remove-AppxProvisionedPackage -Online -Verbose
    }
}
