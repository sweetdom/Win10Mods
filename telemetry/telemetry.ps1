

Write-Host "Disabling telemetry via Group Policies" -ForegroundColor Yellow
mkdir "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Verbose -Force

Set-ItemProperty "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection"`
     -Name "AllowTelemetry"`
     -Value 0

Write-Host "Adding telemetry domains to hosts file"
$hosts_file = "$env:systemroot\System32\drivers\etc\hosts"

Write-Host "Making a backup of your old host file" -ForegroundColor Cyan
Copy-Item $hosts_file `
     -Destination "$env:systemroot\System32\drivers\etc\hosts$(get-date -UFormat "%Y%d%m%H%M")" `
     -Force `
     -Verbose

$Domains = @(
            "a-0001.a-msedge.net"
            "a-0002.a-msedge.net"
            "a-0003.a-msedge.net"
            "a-0004.a-msedge.net"
            "a-0005.a-msedge.net"
            "a-0006.a-msedge.net"
            "a-0007.a-msedge.net"
            "a-0008.a-msedge.net"
            "a-0009.a-msedge.net"
            "a1621.g.akamai.net"
            "a1856.g2.akamai.net"
            "a1961.g.akamai.net"
            "a978.i6g1.akamai.net"
            "a.ads1.msn.com"
            "a.ads2.msads.net"
            "a.ads2.msn.com"
            "ac3.msn.com"
            "ad.doubleclick.net"
            "adnexus.net"
            "adnxs.com"
            "ads1.msads.net"
            "ads1.msn.com"
            "ads.msn.com"
            "aidps.atdmt.com"
            "aka-cdn-ns.adtech.de"
            "a-msedge.net"
            "any.edge.bing.com"
            "a.rad.msn.com"
            "az361816.vo.msecnd.net"
            "az512334.vo.msecnd.net"
            "b.ads1.msn.com"
            "b.ads2.msads.net"
            "bingads.microsoft.com"
            "b.rad.msn.com"
            "bs.serving-sys.com"
            "c.atdmt.com"
            "cdn.atdmt.com"
            "cds26.ams9.msecn.net"
            "choice.microsoft.com"
            "choice.microsoft.com.nsatc.net"
            "c.msn.com"
            "compatexchange.cloudapp.net"
            "corpext.msitadfs.glbdns2.microsoft.com"
            "corp.sts.microsoft.com"
            "cs1.wpc.v0cdn.net"
            "db3aqu.atdmt.com"
            "df.telemetry.microsoft.com"
            "diagnostics.support.microsoft.com"
            "e2835.dspb.akamaiedge.net"
            "e7341.g.akamaiedge.net"
            "e7502.ce.akamaiedge.net"
            "e8218.ce.akamaiedge.net"
            "ec.atdmt.com"
            "fe2.update.microsoft.com.akadns.net"
            "feedback.microsoft-hohm.com"
            "feedback.search.microsoft.com"
            "feedback.windows.com"
            "flex.msn.com"
            "g.msn.com"
            "h1.msn.com"
            "h2.msn.com"
            "hostedocsp.globalsign.com"
            "i1.services.social.microsoft.com"
            "i1.services.social.microsoft.com.nsatc.net"
            "ipv6.msftncsi.com"
            "ipv6.msftncsi.com.edgesuite.net"
            "lb1.www.ms.akadns.net"
            "live.rads.msn.com"
            "m.adnxs.com"
            "msedge.net"
            "msftncsi.com"
            "msnbot-65-55-108-23.search.msn.com"
            "msntest.serving-sys.com"
            "oca.telemetry.microsoft.com"
            "oca.telemetry.microsoft.com.nsatc.net"
            "onesettings-db5.metron.live.nsatc.net"
            "pre.footprintpredict.com"
            "preview.msn.com"
            "rad.live.com"
            "rad.msn.com"
            "redir.metaservices.microsoft.com"
            "reports.wes.df.telemetry.microsoft.com"
            "schemas.microsoft.akadns.net"
            "secure.adnxs.com"
            "secure.flashtalking.com"
            "services.wes.df.telemetry.microsoft.com"
            "settings-sandbox.data.microsoft.com"
            "settings-win.data.microsoft.com"
            "sls.update.microsoft.com.akadns.net"
            "sqm.df.telemetry.microsoft.com"
            "sqm.telemetry.microsoft.com"
            "sqm.telemetry.microsoft.com.nsatc.net"
            "ssw.live.com"
            "static.2mdn.net"
            "statsfe1.ws.microsoft.com"
            "statsfe2.update.microsoft.com.akadns.net"
            "statsfe2.ws.microsoft.com"
            "survey.watson.microsoft.com"
            "telecommand.telemetry.microsoft.com"
            "telecommand.telemetry.microsoft.com.nsatc.net"
            "telemetry.appex.bing.net"
            "telemetry.appex.bing.net:443"
            "telemetry.microsoft.com"
            "telemetry.urs.microsoft.com"
            "vortex-bn2.metron.live.com.nsatc.net"
            "vortex-cy2.metron.live.com.nsatc.net"
            "vortex.data.microsoft.com"
            "vortex-sandbox.data.microsoft.com"
            "vortex-win.data.microsoft.com"
            "watson.live.com"
            "watson.microsoft.com"
            "watson.ppe.telemetry.microsoft.com"
            "watson.telemetry.microsoft.com"
            "watson.telemetry.microsoft.com.nsatc.net"
            "wes.df.telemetry.microsoft.com"
            "win10.ipv6.microsoft.com"
            "www.bingads.microsoft.com"
            "www.go.microsoft.akadns.net"
            "www.msftncsi.com"
            )
$DomainsExtra = @(
                "fe2.update.microsoft.com.akadns.net"
                "s0.2mdn.net"
                "statsfe2.update.microsoft.com.akadns.net",
                "survey.watson.microsoft.com"
                "view.atdmt.com"
                "watson.microsoft.com",
                "watson.ppe.telemetry.microsoft.com"
                "watson.telemetry.microsoft.com",
                "watson.telemetry.microsoft.com.nsatc.net"
                "wes.df.telemetry.microsoft.com"
                "ui.skype.com",
                "pricelist.skype.com"
                "apps.skype.com"
                "m.hotmail.com"
                "s.gateway.messenger.live.com"
                )

if((Read-Host -Prompt "Show host list here?(y/n)") -ilike "y*"){
Write-Host "These Domains will be added to your host file" -ForegroundColor Cyan
Start-Sleep -Seconds 3
Write-Host "$($Domains | Out-String)" -ForegroundColor Cyan
Start-Sleep -Seconds 5
}

Write-Host "These Domain are extra and can be added" -ForegroundColor Yellow

Start-Sleep -Seconds 3

Write-Host "$($DomainsExtra| Out-String)" -ForegroundColor Yellow

$AddextraDomains = Read-Host -Prompt "Add extra domains?(yes/no)"

if($AddextraDomains -ilike "y*"){
    $Domains = $Domains + $DomainsExtra
}


foreach($domain in $Domains){
    $addtohost = Read-Host -Prompt "Add $domain to host(y/n)"
    $entry = "0.0.0.0 $domain"
    if($addtohost -ilike "y*"){
        Write-Host "Adding $entry" -ForegroundColor Yellow
        $entry | Out-File $hosts_file -Encoding ascii -Append
    }else{
        Write-Host "skipping $entry"
    }

}

Write-Host "Adding telemetry ips to firewall" -ForegroundColor Yellow

$ips = @(
        "134.170.30.202"
        "137.116.81.24"
        "157.56.106.189"
        "2.22.61.43"
        "2.22.61.66"
        "204.79.197.200"
        "23.218.212.69"
        "65.39.117.230"
        "65.52.108.33"
        "65.55.108.23"
        )
Write-Host "The following IP's will be blocked" -ForegroundColor Cyan
Start-Sleep -Seconds 3
Write-Host "$($ips | Out-String)" -ForegroundColor Cyan

Remove-NetFirewallRule -DisplayName "Block Telemetry IPs" -ErrorAction SilentlyContinue -Verbose

New-NetFirewallRule -DisplayName "Block Telemetry IPs" `
    -Direction Outbound `
    -Action Block -RemoteAddress ([string[]]$ips)`
    -Verbose


