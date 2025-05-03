$adapterName = "Ethernet"

Disable-NetAdapter -Name $adapterName -Confirm:$false
Start-Sleep -Seconds 3
Enable-NetAdapter -Name $adapterName
