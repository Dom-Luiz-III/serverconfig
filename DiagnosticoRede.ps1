# Define a codificação para UTF-8 com BOM
chcp 65001 > $null

# Iniciando o Diagnóstico de Rede
Write-Host "Testando resolução de DNS com Google, Cloudflare e OpenDNS..."

# Testando DNS com diferentes provedores
nslookup www.google.com 8.8.8.8
nslookup www.google.com 1.1.1.1
nslookup www.google.com 208.67.222.222

Write-Host "`nLimpando cache DNS..."
ipconfig /flushdns

Write-Host "`nPing para sites comuns..."
$sites = @("www.google.com", "www.malwarebytes.com", "www.microsoft.com", "www.anydesk.com")
foreach ($site in $sites) {
    Write-Host "`nPing para $($site):`n"
    ping $site
}

Write-Host "`nRastreamento de rota para www.anydesk.com..."
tracert www.anydesk.com

Write-Host "`nTestando MTU ideal..."
$mtu = 1472
while ($mtu -gt 0) {
    $res = ping -f -l $mtu www.google.com -n 1 | Out-String
    if ($res -like "*Esgotado o tempo limite*") {
        $mtu -= 10
    } else {
        break
    }
}
Write-Host "Maior MTU funcional encontrada: $mtu (Recomendada: 1500)"

Write-Host "`nVerificando se o Firewall do Windows está ativado..."
if (Get-Command Get-NetFirewallProfile -ErrorAction SilentlyContinue) {
    Get-NetFirewallProfile | Format-Table Name, Enabled
} else {
    Write-Host "Comando Get-NetFirewallProfile não disponível neste sistema."
}

Write-Host "`nDiagnóstico concluído."
