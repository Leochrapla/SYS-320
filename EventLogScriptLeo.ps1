
function Get-LoginLogoffEvents {
    param(
        [int]$Days = 14
    )
    
    $loginouts = Get-EventLog -LogName System -Source Microsoft-Windows-Winlogon -After (Get-Date).AddDays(-$Days)

    $loginoutsTable = @() 
    for($i=0; $i -lt $loginouts.Count; $i++){
        
        
        $event = ""
        if($loginouts[$i].InstanceId -eq 7001) {$event="Logon"}
        if($loginouts[$i].InstanceId -eq 7002) {$event="Logoff"}
        
        
        $sid = $loginouts[$i].ReplacementStrings[1]  
        try {
            $objSID = New-Object System.Security.Principal.SecurityIdentifier($sid)
            $objUser = $objSID.Translate([System.Security.Principal.NTAccount])
            $user = $objUser.Value
        }
        catch {
            $user = $loginouts[$i].ReplacementStrings[0]
        }
        
        $loginoutsTable += [PSCustomObject]@{"Time" = $loginouts[$i].TimeGenerated;
                                            "Id" = $loginouts[$i].InstanceId;
                                            "Event" = $event;
                                            "User" = $user;
                                            }
    }

    return $loginoutsTable
}


function Get-StartupShutdownEvents {
    param(
        [int]$Days = 14
    )
    
    
    $events = Get-EventLog -LogName System -After (Get-Date).AddDays(-$Days) | Where-Object {
        $_.EventId -eq 6006 -or $_.EventId -eq 6005
    }

    $eventsTable = @()
    for($i=0; $i -lt $events.Count; $i++){
        
       
        $event = ""
        if($events[$i].EventId -eq 6005) {$event="Startup"}
        if($events[$i].EventId -eq 6006) {$event="Shutdown"}
        
       
        $eventsTable += [PSCustomObject]@{"Time" = $events[$i].TimeGenerated;
                                         "Id" = $events[$i].EventId;
                                         "Event" = $event;
                                         "User" = "System";
                                         }
    }

    return $eventsTable
}

$daysInput = Read-Host "Enter the number of days to retrieve events for"
$days = [int]$daysInput

Write-Host " Login/Logoff Events (Last $days days) "
Get-LoginLogoffEvents -Days $days | Format-Table -AutoSize

Write-Host "Startup/Shutdown Events (Last $days days)" 
Get-StartupShutdownEvents -Days $days | Format-Table -AutoSize