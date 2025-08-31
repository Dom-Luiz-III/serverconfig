-- Verificar versão do SQL
SELECT @@VERSION;

sqlcmd -S SERVSHOP9 -Q "SELECT @@VERSION"

-- Comando para delimitar o limite de RAM consumido pelo SQL Server
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;

EXEC sp_configure 'max server memory', 28000;  
RECONFIGURE;


-- Comando para delimitar o limite de RAM consumido pelo SQL Server (Versão 2012)
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE WITH OVERRIDE;

EXEC sp_configure 'max server memory', 28000;
RECONFIGURE WITH OVERRIDE;



SELECT 
    physical_memory_in_use_kb / 1024 AS Memory_Used_MB,
    locked_page_allocations_kb / 1024 AS Locked_Pages_MB,
    page_fault_count AS Page_Faults,
    memory_utilization_percentage AS Memory_Utilization_Pct,
    process_physical_memory_low AS Is_Memory_Low,
    process_virtual_memory_low AS Is_Virtual_Memory_Low
FROM sys.dm_os_process_memory;

-- Comando para poder assessar um BD sem ter certificado
TrustServerCertificate=True