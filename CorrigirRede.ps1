Write-Host "=> Iniciando diagnóstico e correção de rede ...`n"

# Verificar adaptador ativo
$adapter = Get-NetAdapter | Where-Object {$_.Status -eq "Up" -and $_.Name -like "*Ethernet*"}
if (-not $adapter) {
    Write-Host "Nenhum adaptador ativo encontrado." -ForegroundColor Red
    exit
}
Write-Host "Adaptador ativo: $($adapter.Name)" -ForegroundColor Green

# Tentar liberar IP atual
Write-Host "`nLiberando IP atual..."
ipconfig /release

# Renovar IP via DHCP
Write-Host "`nRenovando IP via DHCP..."
ipconfig /renew

# Se falhar, configurar IP manual
Write-Host "`nConfigurando IP manual como fallback..."
New-NetIPAddress -InterfaceAlias $adapter.Name -IPAddress 192.168.1.200 -PrefixLength 24 -DefaultGateway 192.168.1.1
Set-DnsClientServerAddress -InterfaceAlias $adapter.Name -ServerAddresses ("8.8.8.8", "1.1.1.1")

Write-Host "`nConfiguração manual aplicada." -ForegroundColor Cyan
