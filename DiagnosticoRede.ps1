Write-Host "Testando resolução de DNS com Google, Cloudflare e OpenDNS..."

nslookup www.google.com 8.8.8.8
nslookup www.google.com 1.1.1.1
nslookup www.google.com 208.67.222.222

Write-Host "`nLimpando cache DNS..."
ipconfig /flushdns

Write-Host "`nPing para sites comuns..."

$sites = @("www.google.com", "www.malwarebytes.com", "www.microsoft.com")
foreach ($site in $sites) {
    Write-Host "`nPing para $site:`n"
    ping $site
}

Write-Host "`nRastreamento de rota para www.malwarebytes.com..."
tracert www.malwarebytes.com

Write-Host "`nTestando MTU ideal..."
$mtu = 1472
while ($mtu -gt 0) {
    $res = ping -f -l $mtu www.google.com -n 1
    if ($res -like "*Esgotado o tempo limite*") {
        $mtu -= 10
    } else {
        break
    }
}
Write-Host "Maior MTU funcional encontrada: $mtu (Recomendada: 1500)"

Write-Host "`nVerificando se o Firewall do Windows está ativado..."
Get-NetFirewallProfile | Format-Table Name, Enabled

Write-Host "`nDiagnóstico concluído."
