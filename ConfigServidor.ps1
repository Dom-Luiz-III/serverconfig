# Obter informações de rede (IPv4 e Gateway)
$netAdapter = Get-NetAdapter | Where-Object { $_.Status -eq "Up" } | Select-Object -First 1
$ipConfig = Get-NetIPConfiguration -InterfaceIndex $netAdapter.InterfaceIndex

$ipv4 = $ipConfig.IPv4Address.IPAddress
$gateway = $ipConfig.IPv4DefaultGateway.NextHop
$interfaceAlias = $netAdapter.Name

Write-Host "IPv4 detectado: $ipv4"
Write-Host "Gateway detectado: $gateway"
Write-Host "Interface: $interfaceAlias"

# Desativar todos os perfis do firewall do Windows
Write-Host "Desativando o Firewall..."
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False

# Definir IP fixo e adicionar DNS do Google
Write-Host "Configurando IP fixo e DNS..."

# Remove configuração automática (DHCP)
Remove-NetIPAddress -InterfaceAlias $interfaceAlias -AddressFamily IPv4 -Confirm:$false -ErrorAction SilentlyContinue
Remove-NetRoute -InterfaceAlias $interfaceAlias -Confirm:$false -ErrorAction SilentlyContinue

# Adiciona IP fixo e Gateway
New-NetIPAddress -InterfaceAlias $interfaceAlias -IPAddress $ipv4 -PrefixLength 24 -DefaultGateway $gateway

# Configura DNS primário e secundário do Google
Set-DnsClientServerAddress -InterfaceAlias $interfaceAlias -ServerAddresses ("8.8.8.8", "8.8.4.4")

Write-Host "Configuração concluída."
