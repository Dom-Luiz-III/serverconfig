# comando para configurar relôgio do windows se ele não estiver sincronizado
sc create W32Time binPath= "C:\Windows\System32\svchost.exe -k LocalService" start= auto

net start w32time

w32tm /config /manualpeerlist:"pool.ntp.br" /syncfromflags:manual /reliable:YES /update

w32tm /resync /force




# Se precisar fazer por CMD
cmd /c "sc config w32time start= auto"
cmd /c "sc start w32time"
w32tm /config /manualpeerlist:"pool.ntp.br" /syncfromflags:manual /reliable:YES /update
w32tm /resync /force