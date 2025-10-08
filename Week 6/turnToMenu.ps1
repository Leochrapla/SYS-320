. (Join-Path $PSScriptRoot parselogs.ps1)
. (Join-Path $PSScriptRoot Event-Logs.ps1)
. (Join-Path $PSScriptRoot Users.ps1)
. (Join-Path $PSScriptRoot chromeScript.ps1)

 
$Prompt = "`n"
$Prompt += "Please choose your operation:`n"
$Prompt += "1 - Display last 10 Apache Logs`n"
$Prompt += "2 - Display last 10 failed logins`n"
$Prompt += "3 - display at risk users`n"
$Prompt += "4 - start chrome tab`n"
$Prompt += "5 - Exit`n"

$operation = $true

while($operation){

     Write-Host $Prompt | Out-String
     $choice = Read-Host 

    if($choice -eq 5) {
        Write-Host "Goodbye" | Out-String 
        exit
        $operation = $false
    } 

    elseif($choice -eq 1){

        $apacheLogs = ApacheLogs1 | Select-Object -Last 10

        $apacheLogs
    }
    elseif($choice -eq 2){
        
        getFailedLogins 10 
        
        }
    elseif($choice -eq 3){

           $days = Read-Host -Prompt "Enter the number of days to list at risk users for"
        $riskUsers = getAtRiskUsers $days

        Write-Host ($riskUsers | Format-Table | Out-String)
    }
    elseif($choice -eq 4) {

        chrome
    }
    else {
    Write-Host "please enter a valid input" | Out-String
    }
    }

