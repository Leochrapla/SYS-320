
. (Join-Path $PSScriptRoot "EventLogScriptLeo.ps1")

clear

$loginoutsTable = Get-LoginLogoffEvents -Days 15
$loginoutsTable

$shutdownsTable = Get-StartupShutdownEvents -Days 25 | Where-Object {$_.Event -eq "Shutdown"}
$shutdownsTable

$startupsTable = Get-StartupShutdownEvents -Days 25 | Where-Object {$_.Event -eq "Startup"}
$startupsTable