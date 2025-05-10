-- Verificar versão do SQL
SELECT @@VERSION;

-- Comando para delimitar o limite de RAM consumido pelo SQL Server
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;

EXEC sp_configure 'max server memory', 28000;  
RECONFIGURE;
