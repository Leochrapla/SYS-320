. (Join-Path $PSScriptRoot Users.ps1)
. (Join-Path $PSScriptRoot Event-Logs.ps1)
. (Join-Path $PSScriptRoot String-Helper.ps1)

clear

$Prompt = "`n"
$Prompt += "Please choose your operation:`n"
$Prompt += "1 - List Enabled Users`n"
$Prompt += "2 - List Disabled Users`n"
$Prompt += "3 - Create a User`n"
$Prompt += "4 - Remove a User`n"
$Prompt += "5 - Enable a User`n"
$Prompt += "6 - Disable a User`n"
$Prompt += "7 - Get Log-In Logs`n"
$Prompt += "8 - Get Failed Log-In Logs`n"
$Prompt += "9 - List at Risk Users`n"
$Prompt += "10 - Exit`n"



$operation = $true

while($operation){

    
    Write-Host $Prompt | Out-String
    $choice = Read-Host 


    if($choice -eq 10){
        Write-Host "Goodbye" | Out-String
        exit
        $operation = $false 
    }

    elseif($choice -eq 1){
        $enabledUsers = getEnabledUsers
        Write-Host ($enabledUsers | Format-Table | Out-String)
    }

    elseif($choice -eq 2){
        $notEnabledUsers = getNotEnabledUsers
        Write-Host ($notEnabledUsers | Format-Table | Out-String)
    }


    # Create a user
    elseif($choice -eq 3){ 

        $name = Read-Host -Prompt "Please enter the username for the new user"
        
       
        if(checkUser $name){
            Write-Host "User already exists. Please choose a different username." | Out-String
        }
        else{
            $password = Read-Host -AsSecureString -Prompt "Please enter the password for the new user"
            
        
            if(checkPassword $password){
                createAUser $name $password
                Write-Host "User: $name is created." | Out-String
            }
            else{
                Write-Host "Password does not meet requirements. Must be at least 6 characters with 1 letter, 1 number, and 1 special character." | Out-String
            }
        }
    }


    # Remove a user
    elseif($choice -eq 4){

        $name = Read-Host -Prompt "Please enter the username for the user to be removed"

        if(checkUser $name){
            removeAUser $name
            Write-Host "User: $name Removed." | Out-String
        }
        else{
            Write-Host "User does not exist." | Out-String
        }
    }


    # Enable a user
    elseif($choice -eq 5){

        $name = Read-Host -Prompt "Please enter the username for the user to be enabled"

        if(checkUser $name){
            enableAUser $name
            Write-Host "User: $name Enabled." | Out-String
        }
        else{
            Write-Host "User does not exist." | Out-String
        }
    }


    # Disable a user
    elseif($choice -eq 6){

        $name = Read-Host -Prompt "Please enter the username for the user to be disabled"

        if(checkUser $name){
            disableAUser $name
            Write-Host "User: $name Disabled." | Out-String
        }
        else{
            Write-Host "User does not exist." | Out-String
        }
    }


    elseif($choice -eq 7){

        $name = Read-Host -Prompt "Please enter the username for the user logs"

        if(checkUser $name){
            $days = Read-Host -Prompt "Please enter the number of days to search back"
            $userLogins = getLogInAndOffs $days
            Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name"} | Format-Table | Out-String)
        }
        else{
            Write-Host "User does not exist." | Out-String
        }
    }


    elseif($choice -eq 8){

        $name = Read-Host -Prompt "Please enter the username for the user's failed login logs"

        if(checkUser $name){
            $days = Read-Host -Prompt "Please enter the number of days to search back"
            $userLogins = getFailedLogins $days
            Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name"} | Format-Table | Out-String)
        }
        else{
            Write-Host "User does not exist." | Out-String
        }
    }


    # List at Risk Users
    elseif($choice -eq 9){

        $days = Read-Host -Prompt "Please enter the number of days to search back"
        $failedLogins = getFailedLogins $days
        
        $atRiskUsers = $failedLogins | Group-Object User | Where-Object { $_.Count -gt 10 } | Select-Object Name, Count
        
        if($atRiskUsers){
            Write-Host "`nAt Risk Users (more than 10 failed logins):" | Out-String
            Write-Host ($atRiskUsers | Format-Table | Out-String)
        }
        else{
            Write-Host "No at risk users found." | Out-String
        }
    }

    
    # Invalid choice
    else{
        Write-Host "Invalid choice. Please enter a number between 1 and 10." | Out-String
    }

}